
struct SubRoutine{F, Lifetime, Repeat}
    func::F
end

"""
Struct to create routines
"""
struct Routine{FT}
    subrountines::FT
end



function processloop(p, func::Routine, args, routine_lifetime)
    
end