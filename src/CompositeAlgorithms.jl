export CompositeAlgorithm, prepare, loopexp

struct CompositeAlgorithm{FT, Intervals, T} 
    funcs::T
end

CompositeAlgorithm(funcs::NTuple{N, Any}, intervals::NTuple{N, Int}) where {N} = CompositeAlgorithm{Tuple{funcs...}, (intervals), typeof(funcs)}(funcs)

export CompositeAlgorithm, CompositeAlgorithmPA, CompositeAlgorithmFuncType

type_instances(::CompositeAlgorithm{FT}) where FT = call_all(FT.parameters)
# type_instances(::CompositeAlgorithm{FT, I, T}) where {FT, I, T} = T
get_funcs(ca::CompositeAlgorithm) = ca.funcs


CompositeAlgorithm{FS, Intervals}() where {FS, Intervals} = CompositeAlgorithm{FS, Intervals}(call_all(FS)) 
get_intervals(ca::C) where {C<:CompositeAlgorithm} = C.parameters[2]

tupletype_to_tuple(t) = (t.parameters...,)
get_intervals(ct::Type{<:CompositeAlgorithm}) = ct.parameters[2]

@inline function getvals(ca::CompositeAlgorithm{FT, Is}) where {FT, Is}
    return Val.(Is)
end

"""
Get the number of the function currently being prepared
"""
prepare_number(args) = args.preparing_algo_num[]

get_this_interval(args) = getinterval(getfunc(args.proc), prepare_number(args))

numfuncs(::CompositeAlgorithm{T,I}) where {T,I} = length(I)
@inline getfunc(::CompositeAlgorithm{T,I}, idx) where {T,I} = T.parameters[idx]
@inline getinterval(::CompositeAlgorithm{T,I}, idx) where {T,I} = I[idx]


function prepare(f::CompositeAlgorithm, args)
    (;lifetime) = args

    #Trick to get the number of the function currently being prepared
    args = (;args..., preparing_algo_num = Ref(1))

    # Get the type insances, such that the prepare functions can be defined
    # as prepare(::TypeName, args)
    functions = type_instances(f)

    args = (;args...)
    for func in functions
        getargs = prepare(func, args)
        if !isnothing(getargs)
            args = (;args..., getargs...)
        end

        args.preparing_algo_num[] += 1
    end

    # Delete the preparing_algo_num key
    args = deletekeys(args, :preparing_algo_num)

    return args
end


function processloop(@specialize(p), @specialize(func::CompositeAlgorithm{F,I}), @specialize(args), rp::Repeat{repeats}) where {F,I,repeats}
    before_while(p)
    for _ in 1:repeats
        if !run(p)
            break
        end
        @inline comp_dispatch(func, args)
        inc!(p)
        GC.safepoint()
    end
    after_while(p)
    return cleanup(func, args)
end

"""
Dispatch on a composite function
    Made such that the functions will be completely inlined at compile time
"""
@inlline function comp_dispatch(@specialize(func::CompositeAlgorithm{Fs,I}), args) where {Fs,I}
    @inline _comp_dispatch(typehead(Fs), headval(I), typetail(Fs), gettail(I), args)
end

function _comp_dispatch(@specialize(thisfunc), interval::Val{I}, @specialize(funcs), intervals, args) where I
    if I == 1
        @inline thisfunc(args)
    else
        (;proc) = args
        if loopidx(proc) % I == 0
            @inline thisfunc(args)
        end
    end
    @inline _comp_dispatch(typehead(funcs), headval(intervals), typetail(funcs), gettail(intervals), args)
end

_comp_dispatch(::Nothing, ::Any, ::Any, ::Any, args) = nothing



@inline function typehead(t::Type{T}) where T<:Tuple
    Base.tuple_type_head(T)
end

@inline typehead(::Type{Tuple{}}) = nothing

@inline function typeheadval(t::Type{T}) where T<:Tuple
    Val(typehead(t))
end

@inline typeheadval(::Type{Tuple{}}) = nothing

@inline function typetail(t::Type{T}) where T<:Tuple
    Base.tuple_type_tail(T)
end

@inline typetail(t::Type{Tuple{}}) = nothing

@inline function headval(t::Tuple)
    Val(Base.first(t))
end

@inline headval(::Tuple{}) = nothing

@inline gethead(t::Tuple) = Base.first(t)
@inline gethead(::Tuple{}) = nothing

@inline gettail(t::Tuple) = Base.tail(t)
@inline gettail(::Tuple{}) = nothing





