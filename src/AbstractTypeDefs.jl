abstract type ProcessAlgorithm end
abstract type ProcessLoopAlgorithm <: ProcessAlgorithm end # Algorithms that can be inlined in processloop
abstract type LoopAlgorithm <: ProcessLoopAlgorithm end # Algorithms that have multiple functions and intervals

abstract type AbstractOption end
abstract type ProcessState <: AbstractOption end

abstract type AbstractContext end
abstract type AbstractSubContext end

abstract type AbstractRegistry end

abstract type AbstractAVec{T} <: AbstractVector{T} end
