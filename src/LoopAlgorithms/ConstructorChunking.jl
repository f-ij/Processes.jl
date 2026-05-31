const _LOOP_CONSTRUCTOR_CHUNK_CHILD_LIMIT = 24

"""Return the neutral schedule entry used by a constructor-created chunk wrapper."""
@inline _constructor_chunk_schedule_entry(::Type{CompositeAlgorithm}) = Interval(1)
@inline _constructor_chunk_schedule_entry(::Type{Routine}) = Repeat(1)

"""Return whether one statement-local plan option belongs inside a chunk."""
function _constructor_option_matches_chunk(option::LocalPlanOption, chunk_algos::ChunkAlgos) where {ChunkAlgos<:Tuple}
    for algo in chunk_algos
        _runtime_scoped_wiring_matches_child(algo, option) && return true
    end
    return false
end

@inline _constructor_option_matches_chunk(option, chunk_algos::ChunkAlgos) where {ChunkAlgos<:Tuple} = false

"""Split child-scoped route/share options across constructor-created chunks."""
function _constructor_partition_chunk_options(options::Options, chunks::Chunks) where {Options<:Tuple, Chunks<:Vector}
    chunk_options = [Any[] for _ in chunks]
    outer_options = Any[]
    for option in options
        if option isa LocalPlanOption
            assigned = false
            for idx in eachindex(chunks)
                _constructor_option_matches_chunk(option, chunks[idx]) || continue
                push!(chunk_options[idx], option)
                assigned = true
            end
            assigned || push!(outer_options, option)
        else
            push!(outer_options, option)
        end
    end
    return Tuple(outer_options), map(Tuple, chunk_options)
end

"""
    _constructor_chunked_loopalgorithm(laType, funcs, states, options, schedule; id)

Return a nested loop plan for large constructor inputs, or `nothing` when the
input is small enough to construct directly.
"""
function _constructor_chunked_loopalgorithm(
    laType::Type{LA},
    funcs::Funcs,
    states::States,
    options::Options,
    schedule::Schedule;
    id = nothing,
) where {LA<:Union{CompositeAlgorithm, Routine}, Funcs<:Tuple, States<:Tuple, Options<:Tuple, Schedule<:Tuple}
    length(funcs) <= _LOOP_CONSTRUCTOR_CHUNK_CHILD_LIMIT && return nothing

    chunks = Tuple[]
    schedule_chunks = Tuple[]
    for start_idx in 1:_LOOP_CONSTRUCTOR_CHUNK_CHILD_LIMIT:length(funcs)
        stop_idx = min(start_idx + _LOOP_CONSTRUCTOR_CHUNK_CHILD_LIMIT - 1, length(funcs))
        push!(chunks, funcs[start_idx:stop_idx])
        push!(schedule_chunks, schedule[start_idx:stop_idx])
    end

    outer_options, chunk_options = _constructor_partition_chunk_options(options, chunks)
    chunk_algos = ntuple(length(chunks)) do idx
        LoopAlgorithm(laType, chunks[idx], (), chunk_options[idx], schedule_chunks[idx])
    end
    outer_schedule = ntuple(_ -> _constructor_chunk_schedule_entry(laType), length(chunk_algos))
    return LoopAlgorithm(laType, chunk_algos, states, outer_options, outer_schedule; id)
end
