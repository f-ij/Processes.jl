# General Usage

This is a package to easily deploy, pause and restart algorithms in a fully type stable manner on different threads. It's mostly targeted to help make real time simulations easier. To deploy an algorithm, a user is expected to provide two, or optionally three elements in a specific syntax: A description of what a single step of an algorithm does, a description of what data said algorithm prepares, and optionally a description of how data is to be handled when the algorithm is done running.


## Deploying a Simple Algorithm

Here we will outline the basic steps to deploy a simple algorithm. As an example we will write an algorithm that calculates and stores all the Fibonacci numbers up to number $n$.

```
using Processes

# Definitions

struct Fib end # Name declaration

function Processes.prepare(::Fib, args) # Declaration of what data to prepare
    fib = Int[0,1] # Initial data
    processsizehint!(args, fib)     # Tells the process data is allocated, so that the process
                                    # may try to allocate enough memory before the algorithm is ran

    return (;fib)                   # return a named tuple with all arguments, 
                                    # such that they will become accessible to the main algorithm
end

function (::Fib)(args)              # Description of a single algorithm step
    (;fib) = args                   # unpack the tuple

    push!(fib[end]+fib[end-1], fib) # add the last two numbers and add it to the vector
end

function Processes.cleanup(::Fib, args)
    (;fib) = args
    #  process the data

    return (;...) # return a namedtuple
end

# Create the process object
p = Process(Fib, 1000)  # Calculates a thousand numbers
start(p)                # Starts the calculation
result = fetch(p)                # Waits for the process to finish and fetches the arguments (or the cleaned up namedtuple)
```

The general structure is as follows, first we create a new type, in this case `Fib`. For this type, we extend the function `prepare` that is defined in Processes. The function's first agrument is an object of the type, and the second is a namedtuple, which we name args, holding all the variables that will be passed to the main algorithm.

