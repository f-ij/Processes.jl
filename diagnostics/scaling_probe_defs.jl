using Processes

const MAXN = 24

for i in 1:MAXN
    T = Symbol("Scaling$i")
    isdefined(@__MODULE__, T) && continue
    @eval begin
        struct $T <: Processes.ProcessAlgorithm end
        Processes.init(::$T, ctx) = (;
            $(Symbol("v$(i)_1")) = 0.1, $(Symbol("v$(i)_2")) = 0.2,
            $(Symbol("v$(i)_3")) = 0.3, $(Symbol("v$(i)_4")) = 0.4)
        function Processes.step!(::$T, ctx)
            $(Symbol("v$(i)_1")) = muladd(0.91, ctx.$(Symbol("v$(i)_1")), 0.001)
            $(Symbol("v$(i)_2")) = muladd(0.92, ctx.$(Symbol("v$(i)_2")), 0.03 * $(Symbol("v$(i)_1")))
            $(Symbol("v$(i)_3")) = muladd(0.93, ctx.$(Symbol("v$(i)_3")), 0.03 * $(Symbol("v$(i)_2")))
            $(Symbol("v$(i)_4")) = muladd(0.94, ctx.$(Symbol("v$(i)_4")), 0.03 * $(Symbol("v$(i)_3")))
            return (; $(Symbol("v$(i)_1")), $(Symbol("v$(i)_2")), $(Symbol("v$(i)_3")), $(Symbol("v$(i)_4")))
        end
    end
end

function build_expr(N::Int)
    aliases = [:(@alias $(Symbol("s$i")) = $(Symbol("Scaling$i"))()) for i in 1:N]
    calls = Any[]
    for i in 1:N
        if i == 1
            push!(calls, :($(Symbol("s$i"))()))
        else
            prev = Symbol("s$(i-1)")
            push!(calls, :($(Symbol("s$i"))($(Symbol("v$(i-1)_4")) = $prev.$(Symbol("v$(i-1)_4")))))
        end
    end
    return Expr(:block, aliases..., calls...)
end
