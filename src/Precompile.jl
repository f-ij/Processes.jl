struct _ProcessPrecompileCounter <: ProcessAlgorithm end
struct _ProcessPrecompileScaler <: ProcessAlgorithm end

mutable struct _ProcessPrecompileFakeWorker
    idx::Int
    value::Int
    done::Bool
end

function init(::_ProcessPrecompileCounter, context)
    value = get(context, :value, 0)
    total = get(context, :total, 0)
    return (; value, total)
end

function step!(::_ProcessPrecompileCounter, context)
    value = context.value + 1
    return (; value, total = context.total + value)
end

function cleanup(::_ProcessPrecompileCounter, context)
    return (; total = context.total)
end

function init(::_ProcessPrecompileScaler, context)
    factor = get(context, :factor, 2)
    scaled = get(context, :scaled, 0)
    return (; factor, scaled)
end

function step!(::_ProcessPrecompileScaler, context)
    return (; scaled = context.scaled + context.factor)
end

@setup_workload begin
    @ProcessAlgorithm function ProcessManagerPrecompileStep(
        @managed(
            x = Ref(0.0),
            y = Ref(0.0),
            params = Ref((w = 0.0, b = 0.0)),
            grad_w = Ref(0.0),
            grad_b = Ref(0.0),
            loss = Ref(0.0),
            nseen = Ref(0),
        );
        @inputs((;))
    )
        current = params[]
        prediction = current.w * x[] + current.b
        err = prediction - y[]
        grad_w[] += err * x[]
        grad_b[] += err
        loss[] += 0.5 * err^2
        nseen[] += 1
        return (;)
    end

    function _process_manager_precompile_context(worker)
        return worker.context[ProcessManagerPrecompileStep]
    end

    function _process_manager_precompile_reset!(ctx)
        ctx.grad_w[] = 0.0
        ctx.grad_b[] = 0.0
        ctx.loss[] = 0.0
        ctx.nseen[] = 0
        return ctx
    end

    function _process_manager_precompile_flush!(state, worker_values)
        total_grad_w = 0.0
        total_grad_b = 0.0
        total_loss = 0.0
        total_seen = 0

        for worker in worker_values
            ctx = _process_manager_precompile_context(worker)
            total_grad_w += ctx.grad_w[]
            total_grad_b += ctx.grad_b[]
            total_loss += ctx.loss[]
            total_seen += ctx.nseen[]
            _process_manager_precompile_reset!(ctx)
        end

        if total_seen > 0
            params = state.params[]
            scale = inv(total_seen)
            next_params = (;
                w = params.w - state.lr * total_grad_w * scale,
                b = params.b - state.lr * total_grad_b * scale,
            )
            state.params[] = next_params
            state.total_loss[] = total_loss

            for worker in worker_values
                _process_manager_precompile_context(worker).params[] = next_params
            end
        end

        return state
    end

    @compile_workload begin
        process = Process(_ProcessPrecompileCounter(); repeats = 2)
        run(process)
        wait(process)
        fetch(process)
        close(process)

        typed_process = Process(_ProcessPrecompileCounter; repeats = 1)
        run(typed_process)
        wait(typed_process)
        close(typed_process)

        input_process = Process(
            _ProcessPrecompileCounter,
            Input(_ProcessPrecompileCounter, :value => 3),
            Override(_ProcessPrecompileCounter, :total => 5);
            repeats = 1,
        )
        run(input_process)
        wait(input_process)
        close(input_process)

        async_process = Process(_ProcessPrecompileScaler; repeats = 1)
        makeloop!(async_process; threaded = false)
        wait(async_process)
        close(async_process)

        until_process = Process(
            _ProcessPrecompileCounter();
            lifetime = RepeatOrUntil(_ -> true, 2, :globals),
        )
        run(until_process)
        wait(until_process)
        close(until_process)

        base_process = Process(
            _ProcessPrecompileScaler,
            Input(_ProcessPrecompileScaler, :factor => 4);
            repeats = 1,
        )
        copyinputs(base_process)
        copyoverrides(base_process)
        copytaskdata(
            base_process,
            Input(_ProcessPrecompileScaler, :factor => 5);
            keep_inputs = true,
            keep_overrides = true,
        )
        copied_process = copyprocess(
            base_process,
            Input(_ProcessPrecompileScaler, :factor => 6);
            keep_inputs = false,
            context_builder = td -> initcontext(td),
        )
        run(copied_process)
        wait(copied_process)
        close(copied_process)
        close(base_process)

        routine = Routine(_ProcessPrecompileCounter, _ProcessPrecompileScaler, (2, 1))
        resolve(routine)
        keys(routine)
        propertynames(routine)
        routine_process = Process(routine; repeats = 1)
        run(routine_process)
        wait(routine_process)
        close(routine_process)

        composite = CompositeAlgorithm(
            :counter => _ProcessPrecompileCounter,
            :scaler => _ProcessPrecompileScaler,
            (1, 2),
            Route(_ProcessPrecompileCounter => _ProcessPrecompileScaler, :total => :factor),
        )
        resolved_composite = resolve(composite)
        keys(resolved_composite)
        propertynames(resolved_composite)
        composite_process = Process(composite; repeats = 2)
        run(composite_process)
        wait(composite_process)
        close(composite_process)

        edited_composite = composite |>
            la -> addalgo(la, :extra => _ProcessPrecompileCounter, 1) |>
            la -> changeinterval(la, 1, 2) |>
            la -> changeintervals(la, (1, 1, 1)) |>
            la -> rename(la, :extra => :renamed_extra)
        keys(edited_composite)

        finalized = finalstep(
            CompositeAlgorithm(_ProcessPrecompileCounter, (1,)),
            context -> (; total = context[_ProcessPrecompileCounter].total),
        )
        finalized_process = Process(finalized; repeats = 1)
        run(finalized_process)
        wait(finalized_process)
        fetch(finalized_process)
        close(finalized_process)

        threaded = ThreadedCompositeAlgorithm(_ProcessPrecompileCounter, _ProcessPrecompileScaler, (1, 1))
        resolve(threaded)
        threaded_process = Process(threaded; repeats = 1)
        run(threaded_process)
        wait(threaded_process)
        close(threaded_process)

        dsl_routine = @Routine begin
            _ProcessPrecompileCounter()
            _ProcessPrecompileScaler()
        end
        dsl_routine_process = Process(dsl_routine; repeats = 1)
        run(dsl_routine_process)
        wait(dsl_routine_process)
        close(dsl_routine_process)

        dsl_composite = @CompositeAlgorithm begin
            _ProcessPrecompileCounter()
            _ProcessPrecompileScaler()
        end
        dsl_composite_process = Process(dsl_composite; repeats = 1)
        run(dsl_composite_process)
        wait(dsl_composite_process)
        close(dsl_composite_process)

        fake_events = Int[]
        fake_recipe = (;
            makeworker = (idx, manager) -> _ProcessPrecompileFakeWorker(idx, 0, false),
            prepare! = (slot, job, manager) -> begin
                slot.worker.value = job
                slot.worker.done = false
            end,
            start! = (slot, job, manager) -> (slot.worker.done = true),
            isdone = (slot, manager) -> slot.worker.done,
            finalize! = (slot, job, manager) -> nothing,
            consume! = (slot, job, manager) -> push!(fake_events, slot.worker.value),
            release! = (slot, job, manager) -> (slot.worker.value = 0),
            flush! = manager -> length(fake_events),
            close! = (slot, manager) -> (slot.worker.done = true),
        )
        fake_manager = ProcessManager(
            fake_recipe;
            nworkers = 2,
            flush_policy = FlushEvery(2; drain = true),
            job_type = Int,
            result_type = Nothing,
        )
        run!(fake_manager, 1:3)
        close(fake_manager)

        noflush_manager = ProcessManager(
            fake_recipe;
            nworkers = 1,
            flush_policy = NoFlush(),
            job_type = Int,
            result_type = Nothing,
        )
        dispatch!(noflush_manager, 1)
        poll!(noflush_manager)
        drain!(noflush_manager)
        close(noflush_manager)

        no_drain_manager = ProcessManager(
            fake_recipe;
            nworkers = 1,
            flush_policy = FlushEvery(1; drain = false),
            job_type = Int,
            result_type = Nothing,
        )
        run!(no_drain_manager, 1:2)
        close(no_drain_manager)

        jobs = [(; x = 0.1, y = 0.2), (; x = 0.3, y = 0.4)]
        template = Process(ProcessManagerPrecompileStep; repeats = 1)
        recipe = (;
            initstate = config -> (;
                params = Ref(config.initial_params),
                lr = config.lr,
                total_loss = Ref(0.0),
            ),
            makeworker = (idx, manager) -> copyprocess(template; context = deepcopy(template.context)),
            prepare! = (slot, job, manager) -> begin
                ctx = _process_manager_precompile_context(slot.worker)
                ctx.x[] = job.x
                ctx.y[] = job.y
                ctx.params[] = manager.state.params[]
                resetworker!(slot)
            end,
            flush! = manager -> _process_manager_precompile_flush!(manager.state, workers(manager)),
        )

        manager = ProcessManager(
            recipe;
            nworkers = 2,
            config = (; initial_params = (w = 0.0, b = 0.0), lr = 0.01),
            flush_policy = FlushAtEnd(),
            job_type = eltype(jobs),
            result_type = typeof(template),
        )
        run!(manager, jobs)

        reinit_worker = Process(
            _ProcessPrecompileCounter,
            Input(_ProcessPrecompileCounter, :value => 0);
            repeats = 1,
        )
        reinit_recipe = (;
            prepare! = (slot, job, manager) -> reinitworker!(
                slot,
                Input(_ProcessPrecompileCounter, :value => job),
            ),
            consume! = (slot, job, manager) -> getticks(slot.worker),
        )
        reinit_manager = ProcessManager(
            reinit_recipe;
            workers = [reinit_worker],
            flush_policy = NoFlush(),
            job_type = Int,
            result_type = typeof(reinit_worker),
        )
        run!(reinit_manager, 1:2)
        close(reinit_manager)
    end
end
