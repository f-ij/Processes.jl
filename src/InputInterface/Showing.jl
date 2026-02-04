
########################
### SHOWING ###
########################


@inline function _target_label(x)
    T = Base.unwrap_unionall(typeof(x))
    return string(nameof(T))
end

function Base.summary(io::IO, ov::Input)
    print(io, "Input(target=", _target_label(get_target_algo(ov)), ", vars=", get_vars(ov), ")")
end

function Base.show(io::IO, ov::Input)
    summary(io, ov)
end

function Base.summary(io::IO, ov::Override)
    print(io, "Override(target=", _target_label(get_target_algo(ov)), ", vars=", get_vars(ov), ")")
end

function Base.show(io::IO, ov::Override)
    summary(io, ov)
end

function Base.summary(io::IO, ov::NamedInput)
    print(io, "NamedInput(name=", get_target_name(ov), ", vars=", get_vars(ov), ")")
end

function Base.show(io::IO, ov::NamedInput)
    summary(io, ov)
end

function Base.summary(io::IO, ov::NamedOverride)
    print(io, "NamedOverride(name=", get_target_name(ov), ", vars=", get_vars(ov), ")")
end

function Base.show(io::IO, ov::NamedOverride)
    summary(io, ov)
end