
"""
    filter_args(T, args...)
    filter_args(T, args::Tuple)

Return a tuple containing only those arguments whose static type is a subtype of `T`.

This is intended for specialized vararg/tuple call sites where the tuple type is already
known to the compiler, so the selection can be resolved at compile time instead of by
runtime `filter`/`isa` checks.
"""
@inline filter_args(::Type{T}, args...) where {T} = filter_args(T, args)

@inline @generated function filter_args(::Type{T}, args::Args) where {T, Args<:Tuple}
    kept = Any[]
    for (idx, arg_type) in enumerate(Args.parameters)
        if arg_type <: T
            push!(kept, :(getfield(args, $idx)))
        end
    end
    return Expr(:tuple, kept...)
end