@inline getalgos(pkg::NewPackage) = getfield(pkg, :funcs)
@inline getalgo(pkg::NewPackage, idx) = getalgos(pkg)[idx]
@inline getinitalgos(pkg::NewPackage) = getfield(pkg, :initfuncs)
@inline getinc(pkg::NewPackage) = getfield(pkg, :inc)
@inline inc(pkg::NewPackage) = getinc(pkg)[]
@inline intervals(::Union{NewPackage{Funcs, InitFuncs, Intervals}, Type{<:NewPackage{Funcs, InitFuncs, Intervals}}}) where {Funcs, InitFuncs, Intervals} = Intervals
@inline interval(pkg::Union{NewPackage, Type{<:NewPackage}}, idx) = intervals(pkg)[idx]
@inline getname(::Union{NewPackage{Funcs, InitFuncs, Intervals, CustomName}, Type{<:NewPackage{Funcs, InitFuncs, Intervals, CustomName}}}) where {Funcs, InitFuncs, Intervals, CustomName} = CustomName
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
