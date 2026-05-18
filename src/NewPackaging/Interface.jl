@inline getalgos(pkg::NewPackage) = getfield(pkg, :funcs)
@inline getalgo(pkg::NewPackage, idx) = getalgos(pkg)[idx]
@inline getstates(pkg::NewPackage) = getfield(pkg, :states)
@inline getaliases(pkg::NewPackage) = getfield(pkg, :aliases)
@inline getalias(pkg::NewPackage, idx) = getaliases(pkg)[idx]
@inline getinc(pkg::NewPackage) = getfield(pkg, :inc)
@inline inc(pkg::NewPackage) = getinc(pkg)[]
@inline intervals(::Union{NewPackage{Funcs, States, Intervals}, Type{<:NewPackage{Funcs, States, Intervals}}}) where {Funcs, States, Intervals} = Intervals
@inline interval(pkg::Union{NewPackage, Type{<:NewPackage}}, idx) = intervals(pkg)[idx]
@inline getname(::Union{NewPackage{Funcs, States, Intervals, Aliases, CustomName}, Type{<:NewPackage{Funcs, States, Intervals, Aliases, CustomName}}}) where {Funcs, States, Intervals, Aliases, CustomName} = CustomName
@inline reset!(pkg::NewPackage) = (getinc(pkg)[] = 1; reset!.(getalgos(pkg)); pkg)

@inline @generated function inc!(pkg::NewPackage)
    _lcm = lcm(intervals(pkg)...)
    return :(getinc(pkg)[] = mod1(getinc(pkg)[] + 1, $_lcm))
end

@inline function getmultiplier(contextview::SubContextView{CType, SubKey}, instance::AbstractIdentifiableAlgo) where {CType<:ProcessContext, SubKey}
    registered = getregistry(contextview)[SubKey]
    algo = getalgo(registered)
    if algo isa NewPackage
        return getmultiplier(getregistry(contextview), registered) * _newpackage_child_multiplier(algo, instance)
    end
    return getmultiplier(getregistry(contextview), instance)
end

@inline function getmultiplier(contextview::SubContextView{CType, SubKey}, subpackage::SubPackage) where {CType<:ProcessContext, SubKey}
    registry = getregistry(contextview)
    package = registry[subpackage]
    package_multiplier = static_get_multiplier(registry, package)
    sub_multiplier = getmultiplier(package, subpackage)
    return package_multiplier * sub_multiplier
end
