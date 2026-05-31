using Test
using Processes

struct ScopeSource <: Processes.ProcessAlgorithm end
struct ScopeRelay <: Processes.ProcessAlgorithm end
struct ScopeObserver <: Processes.ProcessAlgorithm end
struct NestedInnerCounter <: Processes.ProcessAlgorithm end
struct NestedOuterCounter <: Processes.ProcessAlgorithm end

"""
    _runtime_scope_width(context)

Return how many subcontexts are visible in the narrow `ProcessContext` that a
runtime-generated child kernel rebuilt for this step.
"""
function _runtime_scope_width(context)
    return length(keys(Processes.get_subcontexts(Processes.getcontext(context))))
end

"""Emit a new local value and record the narrow context width seen by the child."""
function Processes.step!(::ScopeSource, context)
    return (; produced = 1, scope_width = _runtime_scope_width(context))
end

"""Consume a routed sibling value and record the narrow context width."""
function Processes.step!(::ScopeRelay, context)
    return (; relayed = context.from_source + 1, scope_width = _runtime_scope_width(context))
end

"""Consume a second routed sibling value and record the narrow context width."""
function Processes.step!(::ScopeObserver, context)
    return (; seen = context.from_relay, scope_width = _runtime_scope_width(context))
end

"""Initialize the nested inner counter state."""
function Processes.init(::NestedInnerCounter, context)
    return (; count = get(context, :count, 0))
end

"""Initialize the nested outer counter state."""
function Processes.init(::NestedOuterCounter, context)
    return (; count = get(context, :count, 0))
end

"""Increment the nested inner counter."""
function Processes.step!(::NestedInnerCounter, context)
    return (; count = context.count + 1)
end

"""Increment the nested outer counter."""
function Processes.step!(::NestedOuterCounter, context)
    return (; count = context.count + 1)
end

"""Produce a runtime-only temporary for the DSL runtime path test."""
runtime_temp_seed() = 7

"""Read a runtime-only temporary produced by an earlier DSL statement."""
runtime_temp_identity(value) = value

@testset "Runtime-generated partial child steps" begin
    @testset "Children see only the subcontexts they actually need" begin
        algo = CompositeAlgorithm(
            ScopeSource,
            ScopeRelay,
            ScopeObserver,
            (1, 1, 1),
            Route(ScopeSource => ScopeRelay, :produced => :from_source),
            Route(ScopeRelay => ScopeObserver, :relayed => :from_relay),
        )
        resolved = resolve(algo)
        result = run(init(resolved); lifetime = Repeat(0))
        final_context = Processes.context(result)
        bundle = Processes.getruntime_bundle(Processes.getplan(resolved))
        child_steps = Processes.runtime_child_steps(bundle)

        @test Processes.runtime_required_names(child_steps[1]) == (:ScopeSource_1,)
        @test Processes.runtime_required_names(child_steps[2]) == (:ScopeRelay_1, :ScopeSource_1)
        @test Processes.runtime_required_names(child_steps[3]) == (:ScopeObserver_1, :ScopeRelay_1)
        @test Set(Processes.runtime_scope_names(bundle)) == Set((:ScopeSource_1, :ScopeRelay_1, :ScopeObserver_1))

        @test final_context[ScopeSource].scope_width == 1
        @test final_context[ScopeRelay].scope_width == 2
        @test final_context[ScopeObserver].scope_width == 2
        @test final_context[ScopeRelay].relayed == 2
        @test final_context[ScopeObserver].seen == 2
        @test final_context[ScopeSource].produced == 1
    end

    @testset "Nested composite and routine plans still recurse correctly" begin
        inner = CompositeAlgorithm(NestedInnerCounter, (1,))
        outer = CompositeAlgorithm(inner, NestedOuterCounter, (1, 1))
        outer_result = run(init(resolve(outer)); lifetime = Repeat(0))
        outer_context = Processes.context(outer_result)

        @test outer_context[NestedInnerCounter].count == 1
        @test outer_context[NestedOuterCounter].count == 1

        routine = @Routine begin
            @repeat 2 NestedInnerCounter()
        end
        routine_result = run(init(resolve(routine)); lifetime = Repeat(0))
        routine_context = Processes.context(routine_result)

        @test routine_context[NestedInnerCounter].count == 2
    end

    @testset "Runtime-only DSL temporaries stay visible within the same step" begin
        algo = @CompositeAlgorithm begin
            temp = runtime_temp_seed()
            result = runtime_temp_identity(temp)
        end

        process = Process(resolve(algo); repeats = 1)
        run(process)
        wait(process)
        @test Processes.getglobals(fetch(process)).result == 7
        @test !haskey(Processes.getglobals(Processes.context(process)), :temp)
        close(process)
    end
end
