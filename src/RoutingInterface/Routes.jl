
################################################
##################  ROUTES  ####################
################################################

getfrom(r::Route) = r.from
getto(r::Route) = r.to
getvarnames(r::Route) = r.varnames
getaliases(r::Route) = r.aliases
getransform(r::Route) = r.transform