struct KeyMap{TV}
    keyvals::TV
end

struct ValueTuple{TV, KM}
    values::TV
    keymap::KM
end

@inline Base.@constprop :aggressive function Base.getindex(km::KeyMap, key)
    return @inline findfirst(==(key), km.keyvals)
end

@inline Base.@constprop :aggressive function Base.getindex(vt::ValueTuple, key)
    return @inline vt.values[vt.keymap[key]]
end

struct KeyValue
    n::Int
end

k1 = KeyValue(1)
k2 = KeyValue(2)
k3 = KeyValue(3)

km = KeyMap((k1, k2, k3))

function test_keymap()
    k1 = KeyValue(1)
    k2 = KeyValue(2)
    k3 = KeyValue(3)

    km = KeyMap((k1, k2, k3))
    vt = ValueTuple((10, 20, 30), km)

    return @inline vt[k1]
end

@code_warntype test_keymap()

