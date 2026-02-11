################################################
##################  SHARES  ####################
################################################

"""
Whole name space from A1 to A2, optionally directional
"""
struct Share{A1,A2} <: AbstractOption
    algo1::A1
    algo2::A2
    directional::Bool
end
