using MacroTools

#=Grid lattice functions=#

# Matrix Coordinates to vector Coordinates
@inline function coordToIdx(i, j, length)
    return Int32(i + (j - 1) * length)
end

@inline function coordToIdx(i,j,k, len, wid)
    return Int32(i + (j - 1) * len + (k - 1) * len * wid)
end

@inline function coordToIdx(coords::NTuple{N,<:Integer}, size::NTuple{N,<:Integer}) where N
    # Convert
    coords = Int32.(coords)
    size = Int32.(size)
    
    idx = 1
    for i in 1:N
        idx += (coords[i] - 1) * prod(size[1:i-1])
    end
    return idx
end

# Insert coordinates as tuple
coordToIdx((i, j), length::Integer) = coordToIdx(i, j, length)

# Go from idx to lattice coordinates, for rectangular grids
@inline function idxToCoord(idx::T, length::Integer) where T <: Integer
    return (T((idx - 1) % length + 1), T((idx - 1) ÷ length + 1))
end


#TODO Check this one
@inline function idxToCoord(idx::Integer, size::NTuple{DIMS,T}) where {DIMS,T}
    idx = convert(T, idx)
    if DIMS == 2
        r(T((idx - 1) % length + 1), T((idx - 1) ÷ length + 1))
    elseif DIMS == 3
        len = size[1]
        wid = size[2]
        #(i,j,k)
        return (T((idx - 1) % len + 1), T((idx - 1) ÷ len % wid + 1), T((idx - 1) ÷ (len * wid) + 1))
    end
end

"""
Put a lattice index (i or j) back onto lattice by looping in a direction
First argument is index, second is length in that direction
"""
@inline function latmod(idx::T, L::T) where T <: Integer
    # return mod((idx - T(1)), L) + T(1)
    return mod1(idx, L)
end

@inline function latmod(i::T,j::T,layer) where T
    len = glength(layer)
    wid = gwidth(layer)

    return latmod(i,len), latmod(j,wid)
end 

@inline function latmod(i::T,j::T,len::T,wid::T) where T
    return latmod(i,len), latmod(j,wid)
end

@inline function latmod(i::T,j::T,k::T,len::T,wid::T,hei::T) where T
    return latmod(i,len), latmod(j,wid), latmod(k,hei)
end

@inline function latmod(coords::NTuple{N,T}, size::NTuple{N,T}) where {N,T}
    if N == 2
        return latmod(coords[1], coords[2], size[1], size[2])
    elseif N == 3
        return latmod(coords[1], coords[2], coords[3], size[1], size[2], size[3])
    end
end

export latmod

@inline function inlat(idx::T, L::T) where T <: Integer
    if idx <= L && idx > 0
        return idx
    else
        return 0
    end
end


# Array functions

# Searches backwards from idx in list and removes item
# This is because spin idx can only be before it's own index in aliveList
function revRemoveSpin!(list,spin_idx)
    init = min(spin_idx, length(list)) #Initial search index
    for offset in 0:(init-1)
        @inbounds if list[init-offset] == spin_idx
            deleteat!(list,init-offset)
            return init-offset # Returns index where element was found
        end
    end
end

# Zip together two ordered lists into a new ordered list; fast  
function zipOrderedLists(vec1::Vector{T},vec2::Vector{T}) where T
    # result::Vector{T} = zeros(length(vec1)+length(vec2))
    result = Vector{T}(undef, length(vec1)+length(vec2))

    ofs1 = 1
    ofs2 = 1
    while ofs1 <= length(vec1) && ofs2 <= length(vec2)
        @inbounds el1 = vec1[ofs1]
        @inbounds el2 = vec2[ofs2]
        if el1 < el2
            @inbounds result[ofs1+ofs2-1] = el1
            ofs1 += 1
        else
            @inbounds result[ofs1+ofs2-1] = el2
            ofs2 += 1
        end
    end

    if ofs1 <= length(vec1)
        @inbounds result[ofs1+ofs2-1:end] = vec1[ofs1:end]
    else
        @inbounds result[ofs1+ofs2-1:end] = vec2[ofs2:end]
    end
    return result
end

# Deletes els from vec which should be ordered
# Assumes that els are in vec!
# Should I make ordered vec a type?
function remOrdEls(vec::Vector{T}, els::Vector{T}) where T
    # result::Vector{T} = zeros(length(vec)-length(els))
    result = Vector{T}(undef, length(vec)-length(els))
    it_idx = 1
    num_del = 0
    for el in els
            while el != vec[it_idx]
        
            result[it_idx - num_del] = vec[it_idx]
            it_idx +=1
        end
            num_del +=1
            it_idx += 1
    end
        result[(it_idx - num_del):end] = vec[it_idx:end]
    return result
end

# Remove first element equal to el and returns correpsonding index
function removeFirst!(list,el)
    for (idx,item) in enumerate(list)
        if item == el
            deleteat!(list,idx)
            return idx
        end
    end
end

#=
Threads
=#

# Spawn a new thread for a function, but only if no thread for that function was already created
# The function is "locked" using a reference to a Boolean value: spawned
function spawnOne(f::Function, spawned::Ref{Bool}, threadname = "", args... )
    # Run function, when thread is finished mark it as not running
    function runOne(func::Function, spawned::Ref{Bool}, args...)
        func(args...)
        spawned[] = false
        GC.safepoint()
    end

    # Mark as running, then spawn thread
    if !spawned[]
        spawned[] = true
        # Threads.@spawn runOne(f,spawned)
        runOne(f,spawned, args...)
    else
        println("Already spawned" * threadname)
    end
end

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
export setTuple

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
export setterGetter

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

export createArgStruct

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
macro ForwardDeclare(structname, subfolder)
    #get files from current dir
    files = readdir(joinpath(modulefolder, subfolder))

    # get all files that end in .jl
    files = filter(x -> endswith(x, ".jl"), files)

    # add the path to the files
    files = map(x -> joinpath(modulefolder, subfolder, x), files)
    structstring = getstruct(string(structname), files)
    # println(structstring)
    # println("Searching Dir $(@__DIR__)/$subfolder for struct $structname")
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
export @rtime

macro enumeratelayers(layers, length)
    expr = quote end

    for idx in 1:length
        push!(expr.args, Meta.parse("l$idx = $layers[$idx]"))
    end
    esc(expr)
end
export @enumeratelayers

changesize(sp::SparseMatrixCSC, rows, cols) = sparse(findnz(sp)..., rows, cols)

macro tryLockPause(sim, expr, blockpause = false, blockunpause = false)
    fexp = quote end
    push!(fexp.args, :(lockPause($sim, block = $blockpause)))
    push!(fexp.args, :(try $expr ;finally unlockPause($sim, block = $blockunpause) end))

    return esc(fexp)
end
export @tryLockPause

"""
Insert a vector into another vector
"""
function Base.insert!(collection::Vector{T}, idx::Integer, items::Vector{T}) where T
    original_len = length(collection)
    shifted_items = length(collection) - idx + 1
    resize!(collection, length(collection) + length(items))
    collection[end-shifted_items+1:end] = collection[idx:original_len]
    collection[idx:idx+length(items)-1] = items
    return collection
end

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
export getMBytes

function printnz(v)
    for (val_idx, val) in enumerate(v)
        if val != 0
            println("[$val_idx] => $val")
        end
    end
end
export printnz

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

function sumsimd(v::AbstractArray{T}) where T
    cum = zero(T)
    @turbo for idx in eachindex(v)
        cum += v[idx]
    end
    return cum
end
export sumsimd

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
Give a module subfolder and a structname, find the struct in the files in the subfolder
"""
find_struct_in(structname, subfolder) = getstruct(string(structname), readdir(joinpath(modulefolder, subfolder)))

function parameternames(structstr)
    c1 = @capture(Meta.parse(structstr), struct T_ fieldnames__ end)
    if c1
        return T.args[1].args[2:end]
    else
        c2 = @capture(Meta.parse(structstr), mutable struct T_ fieldnames__ end)
        if c2
            return T.args[1].args[2:end]
        end
    end
    return nothing
end

function functionargs(ex)
    @capture(ex2, function f_(xs__) where {T_}  body_ end)
    xs
end

# macro parameterfunc(structname, func_ex)
#     total_ex = quote end
#     # push original func exp
#     push!(total_ex.args, func_ex)
#     # get the struct Parameters
#     p_names = parameternames(find_struct_in(structname, @__DIR__))
#     type_func_ex = deepcopy(func_ex)
#     args = functionargs(type_func_ex)
# end