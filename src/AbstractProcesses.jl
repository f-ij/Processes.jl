abstract type AbstractProcess end

loopidx(p::AbstractProcess) = p.loopidx
setloopidx!(p::AbstractProcess, value) = (p.loopidx = value)
reset_loopidx!(p::AbstractProcess) = setloopidx!(p, oneunit(loopidx(p)))

loopint(p::AbstractProcess) = Int(loopidx(p))
getlidx(p::AbstractProcess) = loopint(p)

@inline inc!(p::AbstractProcess) = p.loopidx += oneunit(p.loopidx)

export AbstractProcess, loopidx, loopint, getlidx, inc!
