################################################
##################  SHARES  ####################
################################################

get_firstalgo(s::Share) = s.algo1
get_secondalgo(s::Share) = s.algo2
is_directional(s::Share) = s.directional


function Share(algo1, algo2; directional::Bool=false)
    Share{typeof(algo1), typeof(algo2)}(algo1, algo2, directional)
end

function update_keys(s::Share, reg::NameSpaceRegistry)
    newalgo1 = update_keys(get_firstalgo(s), reg)
    newalgo2 = update_keys(get_secondalgo(s), reg)
    Share(newalgo1, newalgo2; directional = is_directional(s))
end

function to_sharedcontext(reg::NameSpaceRegistry, s::Share)
    names = (static_findkey(reg, s.algo1), static_findkey(reg, s.algo2))
    if any(isnothing, names)
        available = all_keys(reg)
        available_str = isempty(available) ? "<none>" : join(string.(available), ", ")
        msg = "Share references algo(s) not found in registry.\n" *
              "Requested: " * string(s.algo1) * " (type: " * string(typeof(s.algo1)) * "), " *
              string(s.algo2) * " (type: " * string(typeof(s.algo2)) * ")\n" *
              "Available names: " * available_str
        error(msg)
    end
    nt = (; names[1] => SharedContext{ names[2] }())
    if !s.directional
        nt = (; nt..., names[2] => SharedContext{ names[1] }())
    end
    return nt
end
