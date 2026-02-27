include("_env.jl")

function IntegrateAndLog(type = Float64, loginterval = 1)
    integrator = Integrator(type)
    logger = Logger(type, name = :integrate_and_log)
    c = CompositeAlgorithm(integrator, logger, (1, loginterval), Route(integrator => logger, :total => :value))
    pack = package(c)
end

IntegrateAndLogger = IntegrateAndLog()

@ProcessAlgorithm function generate_values()
    val = rand()
    println("Generated: ", val)
    return (;output = val)
end

comp = CompositeAlgorithm(generate_values, IntegrateAndLogger, (1,1), Route(generate_values => IntegrateAndLogger, :output => :Δvalue))

p = Processes.Process(comp, lifetime = 10, Input(IntegrateAndLogger, initialvalue = 101f0))
run(p)
