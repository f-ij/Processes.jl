macro includefile(filepath)
    esc(Meta.parse(read(open(eval(filepath)), String)))
end

macro includefile(includepath, filename::String)
    esc(Meta.parse(read(open(eval(includepath) * "/" * filename), String)))
end

macro includetextfile(pathsymbs...)
    path = joinpath(@__DIR__,"textfiles", string.(pathsymbs)...)
    esc(Meta.parse(read(open(path), String)))
end

function setTuple(tuple, idx, val)
    if idx == 1
        return (val, tuple[2:end]...)
    elseif idx == length(tuple)
        return (tuple[1:(end-1)]..., val)
    else
        return (tuple[1:(idx-1)]...,val,tuple[(idx+1):end]...)
    end
end

"""
Checks if methods exist for the given name
"""
macro methodexists(methodname)
    try
        methods(eval(methodname))
        return true
    catch e
        return false
    end
end


"""
Registers the fieldnames of some struct B as methods for struct a
where 
    struct A
        b::B
        ...
    end

    struct B
        a
        b
        c
    end

    s.t.

    a = A(...)

    a(a) = a.b.a
    b(a) = a.b.b
    ...

Capitalization and naming has to be done like the above

    Also defines the same methods with an extra argument which are setters
"""
macro forwardfields(Outer, Inner, fieldname = lowercase(string(nameof(eval(Inner)))), deleted...)
    funcs = quote end
    fieldname = string(fieldname)
    for name in fieldnames(eval(Inner))
        if (name ∈ deleted)
            continue
        end
        outername = string(nameof(eval(Outer)))
        outervarname = lowercase(string(nameof(eval(Outer))))

        if @methodexists name
            println("importing $name")
            eval(:(import Base: $name))
        end

        getstr = "@inline $name($outervarname::$(outername)) = $outervarname.$fieldname.$(string(name))"
        setstr = "@inline $(name)!($outervarname::$(outername), val) = $outervarname.$fieldname.$(string(name)) = val"
        setstrdel = "@inline $name($outervarname::$(outername), val) = $outervarname.$fieldname.$(string(name)) = val"

        push!(funcs.args, Meta.parse(getstr))
        push!(funcs.args, Meta.parse(setstr))
        push!(funcs.args, Meta.parse(setstrdel))
        push!(funcs.args, Meta.parse("export $name"))
        
    end
    return esc(funcs)
end

"""
Defines setter and getter functions for all struct fieldnames
"""
macro setterGetter(strct, deleted...)
    funcs = quote end
    strctname = string(nameof(eval(strct)))

    for name in fieldnames(eval(strct))
        if !(name ∈ deleted)
            # strctname = string(nameof(eval(strct)))
            varname = lowercase(string(nameof(eval(strct))))

            if @methodexists name
                println("importing $name")
                eval(:(import Base: $name))
            end

            getstr = "@inline $name($varname::$(strctname)) = $varname.$(string(name))"
            setstr = "@inline $(name)!($varname::$(strctname), val) = $varname.$(string(name)) = val"
            setstrdel = "@inline $name($varname::$(strctname), val) = $varname.$(string(name)) = val"


            push!(funcs.args, Meta.parse(getstr))
            push!(funcs.args, Meta.parse(setstr))
            push!(funcs.args, Meta.parse(setstrdel))
            push!(funcs.args, Meta.parse("export $name"))
        end
    end
    return esc(funcs)

end
macro setterGetterAnnotated(strct, deleted...)
    funcs = quote end
    strctname = string(nameof(eval(strct)))

    for (nameidx,name) in enumerate(fieldnames(eval(strct)))
        if !(name ∈ deleted)
            # strctname = string(nameof(eval(strct)))
            varname = lowercase(string(nameof(eval(strct))))

            if @methodexists name
                println("importing $name")
                eval(:(import Base: $name))
            end

            typestr = string(fieldtypes(eval(strct))[nameidx])

            #check if typestr contains where
            addtype = occursin("where", typestr) ? false : true
            
            typestr = addtype ? "::"*typestr : ""

            getstr = "@inline $name($varname::$(strctname))$typestr = $varname.$(string(name))"
            setstr = "@inline $name($varname::$(strctname), val)$typestr = $varname.$(string(name)) = val"

            push!(funcs.args, Meta.parse(getstr))
            push!(funcs.args, Meta.parse(setstr))
            push!(funcs.args, Meta.parse("export $name"))
        end
    end
    return esc(funcs)

end

macro createArgStruct(name, args...)
    startstr = "struct $name{"
    argstr = ""
    for idx in eachindex(args)
        argstr *= "\t$(args[idx])::T$idx\n"
        startstr *= "T$idx,"
    end
    #remove last character from startstr
    startstr = startstr[1:end-1]
    #close the bracket
    startstr *= "}\n"
    #add the arguments
    startstr *= argstr
    #close the struct
    startstr *= "end"
    return esc(Meta.parse(startstr))
end


macro registerStructVars(varname, structname)
    vars = quote end
    objectname = string(varname)
    # println(typeof(eval(structname)))
    for name in fieldnames(eval(structname))
        push!(vars.args, Meta.parse("$name = $objectname.$name"))
    end

    return esc(vars)
end
export registerStructVars

# Etc
# Not used?
function sortedPair(idx1::Integer,idx2::Integer):: Pair{Integer,Integer}
    if idx1 < idx2
        return idx1 => idx2
    else
        return idx2 => idx1
    end
end

"""
Use a single idx to get an element of a vector of vectors
"""
function vecvecIdx(vec, idx)
    outeridx = 1
    while idx > 0
        tmp_idx = idx - length(vec[outeridx])
        if tmp_idx <= 0 
            return vec[outeridx][idx]
        else
            idx = tmp_idx
            outeridx += 1
        end
    end
end


"""
Expand a vector by creating a copy with extra entries all initialized with val
and return the copy
"""
function expand(vec::Vector{T}, newlength, val) where T
    if length(vec) > newlength
        error("New length must be longer")
    end
    newvec = Vector{T}(undef, newlength)

    newvec[1:length(vec)] .= vec
    
    newvec[(length(vec) + 1):newlength] .= val

    return newvec
end

# Expand a vector with undef
function expand(vec::Vector{T}, newlength) where T
    if length(vec) > newlength
        error("New length must be longer")
    end
    newvec = Vector{T}(undef, newlength)

    newvec[1:length(vec)] .= vec

    return newvec
end

# Insert an item into an ordered list and deduplicate
insert_and_dedup!(v::Vector, x) = (splice!(v, searchsorted(v,x), [x]); v)::Vector{Tuple{Int32,Float32}}

# macro that takes a description of a struct and fowards declares it by putting a try catch block around it
macro ForwardDeclare(strct)
    return quote
        try
            $(esc(strct))
        catch
        end
    end
end

function getword(stream::IOBuffer; ignore_comment = false)::String
    string = Char[]
    char = ' '
    while !eof(stream) && isspace(char)
        char = read(stream, Char)
        if ignore_comment && char == '#'
            while !eof(stream) && char != '\n'
                char = read(stream, Char)
            end
        end
    end
    
    while !eof(stream) && !isspace(char)
        push!(string, char)
        char = read(stream, Char)
    end

    return join(string)
end

#forward declaration of struct that reads all files in the same folder
function getstruct(strctname, files)
    # for every file look for the word struct
    range = nothing
    fileidx = 1
    for (idx, file) in enumerate(files)
        # read the file
        filestr = read(file, String)
        # find the index of the word struct
        range = findfirst("struct $strctname", filestr)

        # if it's found break the loop
        if !isnothing(range)
            mutablerange = (range[1]- 8):(range[1]-2)

            if range[1] >= 9 && filestr[mutablerange] == "mutable"
                range = mutablerange[1]:range[end]
            end

            fileidx = idx
            break
        end
    end

    file = read(files[fileidx], String)
    # add string until "end" is found
    # find next occurrence of "end" after range
    endrange = range
    stream = IOBuffer(file[1:end])
    stream.ptr = endrange[end]
    open_expressions = 1
    num_ends = 0
    open_expression_terms = ["function", "while", "for", "if", "begin", "let", "quote", "do"]
    while open_expressions > num_ends || eof(stream)
        # Fix so that it also works         
        # word = readuntil(stream, ' ', keep = false)
        word = getword(stream, ignore_comment = true)
        if '#' ∈ word
            readline(stream)
        end 
        # word = strip(word)
        if word ∈ open_expression_terms
            open_expressions += 1
        elseif word == "end"
            num_ends += 1
        end
    end

    endrange = stream.ptr - 1
    str = file[range[1]:endrange[end]]
    return str
end

#macro defines a struct with the given name in a try catch block
# with a field that has a type that's gona make it fail
macro ForwardDeclare(structname, funcfolder)
    #get files from current dir
    files = readdir(joinpath(modulefolder, funcfolder))

    # get all files that end in .jl
    files = filter(x -> endswith(x, ".jl"), files)

    # add the path to the files
    files = map(x -> joinpath(modulefolder, funcfolder, x), files)
    structstring = getstruct(string(structname), files)
    # println(structstring)
    # println("Searching Dir $(@__DIR__)/$funcfolder for struct $structname")
    expr = Meta.parse(structstring)

    return esc(quote
                try
                    $expr
                catch
                end
            end)
end

# Repeat and time
macro rtime(n, expr)
    return esc(quote
        local ti = time()
        for _ in 1:$n
            $expr
        end
        local tf = time()
        println("The repetitions took $(tf-ti) seconds")
    end)
end

macro tryLockPause(sim, expr, blockpause = false, blockunpause = false)
    fexp = quote end
    push!(fexp.args, :(lockPause($sim, block = $blockpause)))
    push!(fexp.args, :(try $expr ;finally unlockPause($sim, block = $blockunpause) end))

    return esc(fexp)
end
export @tryLockPause

#TIME 
getnowtime() =  begin nowtime = string(now())[1:(end-7)]; nowtime = replace(nowtime, ":" => "."); return nowtime end


macro justtry(ex)
    quote
        try
            $(esc(ex))
        catch
            
        end
    end
end

function getMBytes(x)
    total = 0;
    fieldNames = fieldnames(typeof(x));
    if isempty(fieldNames)
       return sizeof(x)/1000^2;
    else
      for fieldName in fieldNames
         total += getMBytes(getfield(x,fieldName));
      end
      return total;
    end
end

function printnz(v)
    for (val_idx, val) in enumerate(v)
        if val != 0
            println("[$val_idx] => $val")
        end
    end
end

"""
Sleep with lower minimum sleeptime
"""
function sleepy(sleeptime, previous_time = time())
    while time() - previous_time < sleeptime
    end
end

"""
Naive async sleep with low sleeptime
"""
function async_sleepy(sleeptime, previous_time = time())
    while time() - previous_time < sleeptime
        yield()
    end
end

"""
Given a range and a number, get the index of that item in the range, rounded down
"""
function rangeidx(range, value)
    partialsortperm(abs.(range .- value), 1)[1]
end
export rangeidx

"""
Deepcopy all the fields of one struct to another.
"""
function copyfields!(oldstruct::T, newsrtuct::T) where T
    for fieldname in fieldnames(T)
        setfield!(oldstruct, fieldname, deepcopy(getfield(newsrtuct, fieldname)))
    end
    oldstruct
end

function idx2coords(size::NTuple{3,T}, idx) where {T}
    idx = T(idx)
    ((T(idx)-T(1)) % size[1] + T(1), (floor(T, (idx-T(1))/size[1])) % size[2] + T(1), floor(T, (idx-T(1))/(size[1]*size[2])) + T(1))
end

idx2ycoord(size::NTuple{3,T}, idx) where {T} = (T(idx)-T(1)) % size[1] + T(1)
idx2xcoord(size::NTuple{3,T}, idx) where {T} = (floor(T, (idx-T(1))/size[1])) % size[2] + T(1)
idx2zcoord(size::NTuple{3,T}, idx) where {T} = floor(T, (idx-T(1))/(size[1]*size[2])) + T(1)



##### WRITE A FUNCTION THAT WORKS AUTOMATICALLY FOR THE TYPE AND TYPE SELECTOR

"""
Give a module funcfolder and a structname, find the struct in the files in the funcfolder
"""
find_struct_in(structname, funcfolder) = getstruct(string(structname), readdir(joinpath(modulefolder, funcfolder)))

"""
From a tuple of struct names, get the fieldnames of the first struct
"""
call_all(tup) = map(f -> f(), tup)


"""
Check if function is defined for arg
"""
function iserror(func, arg)
    try
        func(arg)
        return false
    catch
        return true
    end
end


function deletekey(ps::Base.Pairs, key)
    _keys = collect(keys(ps))
    filter!(x -> x != key, _keys)
    if !isempty(_keys)
        return pairs(ps[_keys...])
    else
        pairs((;))
    end
end
"""
From kwargs delete a key
"""
function deletekey(ps::Union{Base.Pairs, NamedTuple}, key)
    _keys = collect(keys(ps))
    filter!(x -> x != key, _keys)
    if !isempty(_keys)
        if ps isa NamedTuple
            ps[_keys]
        else
            pairs(ps[_keys...])
        end
    else
        if typeof ps isa NamedTuple
            return NamedTuple()
        else
            return pairs((;))
        end

    end
end


"""
From kwargs delete a key
"""
@inline deletekeys(ps::NamedTuple, ks::Symbol...) = deletekeys(ps, Val.(ks)...)
@inline @generated function deletekeys(ps::NamedTuple, ks::Val...)
    names = ps.parameters[1]
    drop_syms = isempty(ks) ? () : Tuple(k.parameters[1] for k in ks)
    keep_syms = Tuple(name for name in names if !(name in drop_syms))

    if isempty(keep_syms)
        return :(NamedTuple())
    end

    value_exprs = [:(getfield(ps, $(QuoteNode(name)))) for name in keep_syms]
    pairs = [:( $(QuoteNode(name)) => $(value_exprs[idx]) ) for (idx, name) in enumerate(keep_syms)]
    return :(; $(pairs...))
end

function deletevalues(ps::NamedTuple, vs...)
    leftover_keys = filter(x -> !(getfield(ps, x) in vs), collect(keys(ps)))
    return ps[leftover_keys]
end

function renamekeys(ps::NamedTuple, keymap::Pair...)
    newtuple = (;ps..., (last(keymap[i]) => ps[first(keymap[i])] for i in 1:length(keymap))...)
    return deletekeys(newtuple, first.(keymap)...)
end


#### Tuple Types
@inline function typehead(t::Type{T}) where T<:Tuple
    Base.tuple_type_head(T)
end

@inline typehead(::Type{Tuple{}}) = nothing

@inline function typeheadval(t::Type{T}) where T<:Tuple
    Val(typehead(t))
end

@inline typeheadval(::Type{Tuple{}}) = nothing

@inline function typetail(t::Type{T}) where T<:Tuple
    Base.tuple_type_tail(T)
end

@inline typetail(t::Type{Tuple{}}) = nothing

@inline function headval(t::Tuple)
    Val(Base.first(t))
end

@inline headval(::Tuple{}) = nothing

@inline gethead(t::Tuple) = Base.first(t)
@inline gethead(::Tuple{}) = nothing

@inline gettail(t::Tuple) = Base.tail(t)
@inline gettail(::Tuple{}) = nothing

"""
Const propagation for tuple type properties.
If you have a function that gets a property for a type,
    this kind of broadcasts that function to a tuple type
"""
function tuple_type_property(propf, t::Type{T}) where T<:Tuple
    _tuple_type_property(propf, (propf(typehead(t)),), typetail(t))
end

function _tuple_type_property(propf, acc, tail)
    if tail == Tuple{}
        return acc
    else
        return _tuple_type_property(propf, (acc..., propf(typehead(tail))), typetail(tail))
    end
end




# function Base.println(io::IndentIO, args...)    
#     # Convert arguments to a single string
#     text = join(args)
    
#     # Split by newlines to ensure correct indentation for multi-line output
#     lines = split(text, '\n')

#     # Print each line with the indentation prefix
#     for (i, line) in enumerate(lines)
#         if i > 1  # For funcsequent lines, only apply indentation
#             print(io.io, getindent(io))
#         else  # First line gets special prefix
#             print(io.io, getindent(io))
#         end

#         if isempty(io.postfixes)
#             println(io.io, line)  # Print the actual content
#         else
#             println(io.io, line, dequeue!(io.postfixes))
#         end
#     end
# end

# function Base.print(io::IndentIO, args...)
#     # Convert arguments to a single string
#     text = join(args)
    
#     # Split by newlines to ensure correct indentation for multi-line output
#     lines = split(text, '\n')

#     # Print each line with the indentation prefix
#     for (i, line) in enumerate(lines)
#         if i > 1  # For funcsequent lines, only apply indentation
#             print(io.io, getindent(io))
#         else  # First line gets special prefix
#             print(io.io, getindent(io))
#         end
#         print(io.io, line, dequeue!(io.postfixes))  # Print the actual content
#     end
# end


"""
Replace a field in a struct by name and return a new instance
"""
@inline setproperty(val::V, name::Symbol, value, custom_constructor = nothing) where {V} = setproperty(val, Val(name), value, custom_constructor)
@generated function setproperty(val::V, name::Val{s}, value, custom_constructor = nothing) where {V,s}
    fieldnames = Base.fieldnames(V)
    constructor = nothing
    if custom_constructor <: Nothing
        constructor = nameof(V)
    else
        constructor = :custom_constructor
    end
     
    exp = Expr(:call, constructor, [field != s ? :(val.$(field)) : :(value) for field in fieldnames]...)
    return exp
end

