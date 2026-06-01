using Processes

const NMAX = 48
for i in 1:NMAX
    T = Symbol("Nest$i")
    isdefined(@__MODULE__, T) && continue
    @eval begin
        struct $T <: Processes.ProcessAlgorithm end
        Processes.init(::$T, ctx) = (;
            $(Symbol("w$(i)_1")) = 0.1, $(Symbol("w$(i)_2")) = 0.2,
            $(Symbol("w$(i)_3")) = 0.3, $(Symbol("w$(i)_4")) = 0.4)
        function Processes.step!(::$T, ctx)
            $(Symbol("w$(i)_1")) = muladd(0.91, ctx.$(Symbol("w$(i)_1")), 0.001)
            $(Symbol("w$(i)_2")) = muladd(0.92, ctx.$(Symbol("w$(i)_2")), 0.03 * $(Symbol("w$(i)_1")))
            $(Symbol("w$(i)_3")) = muladd(0.93, ctx.$(Symbol("w$(i)_3")), 0.03 * $(Symbol("w$(i)_2")))
            $(Symbol("w$(i)_4")) = muladd(0.94, ctx.$(Symbol("w$(i)_4")), 0.03 * $(Symbol("w$(i)_3")))
            return (; $(Symbol("w$(i)_1")), $(Symbol("w$(i)_2")), $(Symbol("w$(i)_3")), $(Symbol("w$(i)_4")))
        end
    end
end

# Build a composite with B blocks; each block is a @repeat R wrapping a chain of W algos.
function build_nested_expr(B::Int, W::Int, R::Int)
    @assert B * W <= NMAX
    aliases = Any[]
    idx = 0
    blockstmts = Any[]
    for b in 1:B
        chain = Any[]
        firstidx = idx + 1
        for w in 1:W
            idx += 1
            si = Symbol("n$idx")
            push!(aliases, :(@alias $si = $(Symbol("Nest$idx"))()))
            if w == 1
                push!(chain, :($si()))
            else
                prev = Symbol("n$(idx-1)")
                push!(chain, :($si($(Symbol("w$(idx-1)_4")) = $prev.$(Symbol("w$(idx-1)_4")))))
            end
        end
        # capture last var in the repeat block
        lastidx = idx
        capture = Symbol("blk$b")
        lastassign = :($capture = $(Symbol("n$lastidx"))($(Symbol("w$(lastidx-1)_4")) = $(Symbol("n$(lastidx-1)")).$(Symbol("w$(lastidx-1)_4"))))
        chain[end] = lastassign
        push!(blockstmts, :($capture = @repeat $R begin $(chain...) end))
    end
    return Expr(:block, aliases..., blockstmts...)
end
