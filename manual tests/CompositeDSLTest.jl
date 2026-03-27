include("_env.jl")

struct SourceAlgo <: Processes.ProcessAlgorithm end
struct CombineAlgo <: Processes.ProcessAlgorithm end
struct SinkAlgo <: Processes.ProcessAlgorithm end

function Processes.step!(::SourceAlgo, context)
    return (; produced = 2, passthrough = context.seed)
end

function Processes.step!(::CombineAlgo, context)
    return (; combined = context.left + context.right)
end

function Processes.step!(::SinkAlgo, context)
    return (; seen = context.value)
end

scaled_double(x; scale = 1) = scale * (2x)

n = 10
algo = @CompositeAlgorithm begin
    @state seed = 3
    @state doubled = 10
    @alias source = SourceAlgo
    produced, passthrough = source(seed = seed)
    doubled = @interval n scaled_double(produced; scale = 2)
    combined = CombineAlgo(left = passthrough, right = doubled)
    SinkAlgo(value = combined)
end

resolved = resolve(algo)
@assert resolved isa CompositeAlgorithm
@assert intervals(resolved) == (1, 10, 1, 1)
@assert Processes.getkey(Processes.getalgo(resolved, 1)) == :source
@assert length(Processes.getstates(resolved)) == 1
@assert Processes.getkey(first(Processes.getstates(resolved))) == :_state

process_repeat = Process(resolved, repeat = 10)
@assert repeats(Processes.lifetime(process_repeat)) == 10

process_indefinite = Process(resolved, repeat = Inf)
@assert Processes.lifetime(process_indefinite) isa Indefinite

opts = Processes.getoptions(resolved)
sharedcontexts, sharedvars = Processes._resolve_options(resolved)
@assert opts == Processes.merge_nested_namedtuples(sharedvars, sharedcontexts)

wrapped = FuncWrapper(x -> 2x, (:x,), (:y,))
@assert Processes.step!(wrapped, (; x = 4)) == (; y = 8)
@assert Processes.init(wrapped, (; x = 4)) == (; y = 8)

kw_wrapped = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (; scale = 3))
Processes.step!(kw_wrapped, (;external = 4))
@assert Processes.step!(kw_wrapped, (; external = 4)) == (; y = 12)
@assert Processes.init(kw_wrapped, (; external = 4)) == (; y = 12)

kw_from_context = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (; scale = :factor))
@assert Processes.step!(kw_from_context, (; external = 4, factor = 5)) == (; y = 20)
@assert Processes.init(kw_from_context, (; external = 4, factor = 5)) == (; y = 20)

kw_same_name = FuncWrapper((x; scale = 1) -> scale * x, (:external,), (:y,), (:scale,))
@assert Processes.step!(kw_same_name, (; external = 4, scale = 6)) == (; y = 24)
@assert Processes.init(kw_same_name, (; external = 4, scale = 6)) == (; y = 24)

state = @state begin
    a = 1
    b
end

@assert Processes.init(state, (; b = 4)) == (; a = 1, b = 4)
@assert Processes.init(state, (; a = 7, b = 4)) == (; a = 7, b = 4)

named_state_algo = @CompositeAlgorithm begin
    @state mystate begin
        a = 1
    end
    SinkAlgo(value = a)
end

resolved_named_state = resolve(named_state_algo)
@assert Processes.getkey(first(Processes.getstates(resolved_named_state))) == :mystate

repeated = @CompositeAlgorithm begin
    @state produced = 5
    tripled = @repeat 3 begin
        tripled = scaled_double(produced; scale = 3)
    end
end

resolved_repeated = resolve(repeated)
@assert resolved_repeated isa CompositeAlgorithm
@assert Processes.getalgo(resolved_repeated, 1) isa Processes.AbstractIdentifiableAlgo
@assert Processes.getalgo(Processes.getalgo(resolved_repeated, 1)) isa Routine
@assert repeats(Processes.getalgo(Processes.getalgo(resolved_repeated, 1))) == (3,)

routine = @Routine begin
    @state produced = 5
    tripled = @repeat 3 scaled_double(produced; scale = 3)
end

resolved_routine = resolve(routine)
@assert resolved_routine isa Routine
@assert repeats(resolved_routine) == (3,)

p = Process(resolved, 10)
cn = fetch(run(p))
