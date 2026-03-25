include("_env.jl")

Processes.@ProcessAlgorithmNew function CopyArray(a::Vector, @managed(buffer = type[]); @init((;type = Float64)))
    resize!(buffer, size(a)...)
    buffer .= a
    return 
end

Processes.@ProcessAlgorithmNew function ProvideArray(@managed(array = rand(10,10)); @init (;type = Float64))
    return 
end

c1 = Unique(CopyArray())
c2 = Unique(CopyArray())

c = CompositeAlgorithm(ProvideArray, c1, c2, 
    Route(ProvideArray => c1, :array => :a),
    Route(ProvideArray => c2, :array => :a))
p = InlineProcess(c, Input(ProvideArray, type = Float32), Input(c1, type = Float32))
c = run(p)

