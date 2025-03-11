struct SimpleAlgo{T} <: ProcessLoopAlgorithm
    func::T

    function SimpleAlgo(f)
        if f isa Type
            return new{f}(f())
        else
            return new{typeof(f)}(f)
        end
    end
end

"""
Wrapper for functions to ensure proper semantics with the task system
"""
@inline function (sf::SimpleAlgo)(args)
    (;proc) = args
    sf.func(args)
    inc!(proc)
    GC.safepoint()
end

function prepare(sa::SimpleAlgo, args)
    (;args..., prepare(sa.func, args)...)
end