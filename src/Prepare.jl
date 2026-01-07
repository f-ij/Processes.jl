"""
Fallback prepare
"""
const warnset = Set{Any}()
function prepare(t::T, ::Any) where T
    if !in(T, warnset)
        @warn "No prepare function defined for var $t with type $T, returning empty args"
        push!(warnset, T)
    end
    (;)
end

# prepare_args(p::AbstractProcess) = prepare_args(p, p.taskdata.func; lifetime = tasklifetime(p), overrides = overrides(p), args(p)...)
# prepare_args!(p::AbstractProcess) = p.taskdata = preparedargs(p.taskdata, prepare_args(p))

# prepare(p::AbstractProcess; args...) = prepare_args(p, getfunc(p); args...)
# function prepare_args(td::TD; lifetime = Indefinite(), overrides = (;), skip_prepare = false, args...) where {TD<:TaskData}


"""
Algorithm to prepare args
Uses same data as taskdata

Expects a lifetime, overrides and args
"""
function prepare_args(algo::F; lifetime = Indefinite(), overrides = (;), skip_prepare = false, args...) where {F}
    # If prepare is skipped, then the prepared arguments are already stored in the process
    #TODO: RESET! Algo?
    reset!(algo)

    prepared_args = nothing

    if isnothing(get(overrides, :prepare, nothing)) # If prepare is nothing, then the user didn't specify a prepare function
        @static if DEBUG_MODE
            println("No prepare function override)")
            println("Preparing args for algo of type $(typeof(algo)) with lifetime $lifetime and args $args")
        end

        prepared_args = prepare(algo, (;lifetime, args...))
    else
        prepared_args = overrides.prepare(algo, (;lifetime, args...))
    end
    if isnothing(prepared_args)
        prepared_args = (;)
    end

    algo_args = (;lifetime, prepared_args...)
        
    algo_args = deletevalues(algo_args, nothing) 

    return algo_args
end

function prepare_args(td::TD) where {TD<:TaskData}
    lifetime = td.lifetime
    overrides = td.overrides
    args = td.inputargs
    
    return prepare_args(td.func; lifetime = lifetime, overrides = overrides, args...)
end


function preparedata!(process::AbstractProcess) 
    @static if DEBUG_MODE
        println("Creating task for process $(process.id)")
    end

    func = process.taskdata.func
    reset!(func) # Reset the loop counters for Routines and CompositeAlgorithms

    # timeouttime = get(overrides, :timeout, 1.0)

    prepared_args = prepare_args(process.taskdata)
    # Add process to args
    # prepared_args = (;proc = process, prepared_args...)

    @static if DEBUG_MODE
        display("Prepared args are $prepared_args")
    end

    # Create new taskdata
    # process.taskdata = TaskData(func, inputargs, overrides, lifetime, Ref(true) ,timeouttime)
    process.args = prepared_args
end

function cleanup(p::AbstractProcess)
    lifetime = tasklifetime(p)
    returnargs = cleanup(getfunc(p), (;proc = p, lifetime, getargs(p)...))
    return deletekeys(returnargs, :proc, :lifetime)
end

export preparedata!, cleanup

