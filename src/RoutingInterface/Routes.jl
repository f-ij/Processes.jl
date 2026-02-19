
################################################
##################  ROUTES  ####################
################################################

getfrom(r::Route) = r.from
getto(r::Route) = r.to

getvarnames(r::Union{Route{F,T, FT, varnames, aliases, Fmatch, Tmatch}, Type{<:Route{F,T, FT, varnames, aliases, Fmatch, Tmatch}}}) where {F,T, FT, varnames, aliases, Fmatch, Tmatch} = varnames
getaliases(r::Union{Route{F,T, FT, varnames, aliases, Fmatch, Tmatch}, Type{<:Route{F,T, FT, varnames, aliases, Fmatch, Tmatch}}}) where {F,T, FT, varnames, aliases, Fmatch, Tmatch} = aliases
gettransform(r::Union{Route{F,T, FT, varnames, aliases, Fmatch, Tmatch}, Type{<:Route{F,T, FT, varnames, aliases, Fmatch, Tmatch}}}) where {F,T, FT, varnames, aliases, Fmatch, Tmatch} = FT

from_match_by(r::Union{Route{F, T, FT, varnames, aliases, Fmatch, Tmatch}, Type{<:Route{F, T, FT, varnames, aliases, Fmatch, Tmatch}}}) where {F, T, FT, varnames, aliases, Fmatch, Tmatch} = Fmatch
to_match_by(r::Union{Route{F, T, FT, varnames, aliases, Fmatch, Tmatch}, Type{<:Route{F, T, FT, varnames, aliases, Fmatch, Tmatch}}}) where {F, T, FT, varnames, aliases, Fmatch, Tmatch} = Tmatch
