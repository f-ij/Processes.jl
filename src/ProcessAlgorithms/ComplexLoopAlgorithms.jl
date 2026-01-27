getmultiplier(cla::ComplexLoopAlgorithm, obj) = getmultiplier(get_registry(cla), obj)
getname(cla::ComplexLoopAlgorithm, obj) = getname(get_registry(cla), obj)

get_sharedcontexts(cla::ComplexLoopAlgorithm) = filter(x -> x isa SharedContext, getoptions(cla))
get_sharedvars(cla::ComplexLoopAlgorithm) = filter(x -> x isa SharedVar, getoptions(cla))

function update_scope(cla::ComplexLoopAlgorithm, newreg::NameSpaceRegistry)
    updated_reg, _ = updatenames(cla.registry, newreg)
    # @show updated_reg
    return setfield(cla, :registry, updated_reg)
end

function match_cla(claT1::Type{<:ComplexLoopAlgorithm}, checkobj)
    if !(checkobj <: ComplexLoopAlgorithm)
        return false
    end
    return getid(claT1) == getid(checkobj)
end