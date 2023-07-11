# Defaults AbstractMetNet-like objects LEP interface methods implementation

import MetXBase.lepmodel
function lepmodel(net::AbstractMetNet) 
    net = metnet(net)
    LEPModel(
        net.S, 
        net.b, 
        net.lb, net.ub, 
        net.c, 
        nothing, # net.C , # TODO: Add C to AbstractMetNet?
        net.mets, 
        net.rxns, 
        net.extras
    )
end

import MetXBase.rowids
rowids(net::AbstractMetNet) = metabolites(net)

import MetXBase.colids
colids(net::AbstractMetNet) = reactions(net)


## -------------------------------------------------------------------
# LEP Setters
import MetXBase.cost_matrix!
export cost_matrix!
cost_matrix!(lep::AbstractMetNet, rider, cider, val) =  
    (_setindex!(lep.S, rowindex(lep, rider), colindex(lep, cider), val); lep)

import MetXBase.balance!
export balance!
balance!(lep::AbstractMetNet, rider, val) = 
    (_setindex!(lep.b, rowindex(lep, rider), val); lep)

import MetXBase.ub!
export ub!
ub!(lep::AbstractMetNet, cider, val) = 
    (_setindex!(lep.ub, colindex(lep, cider), val); lep)
ub!(lep::AbstractMetNet, val) = 
    (_setindex!(lep.ub, Colon(), val); lep)

import MetXBase.lb!
export lb!
lb!(lep::AbstractMetNet, cider, val) = 
    (_setindex!(lep.lb, colindex(lep, cider), val); lep)
lb!(lep::AbstractMetNet, val) = 
    (_setindex!(lep.lb, Colon(), val); lep)

import MetXBase.bounds!
export bounds!
function bounds!(lep::AbstractMetNet, ider, lb, ub)
    idx = colindex(lep, ider)
    ub!(lep, idx, ub)
    lb!(lep, idx, lb)
    return lep
end

function bounds!(lep::AbstractMetNet, ider;
        lb = nothing,
        ub = nothing,
    )
    idx = colindex(lep, ider)
    isnothing(ub) || ub!(lep, idx, ub)
    isnothing(lb) || lb!(lep, idx, lb)
    return lep
end

import MetXBase.linear_weights!
export linear_weights!
function linear_weights!(lep::AbstractMetNet, ider, val) 
    _setindex!(lep.c, zero(eltype(lep.c)))
    idxs = colindex(lep, ider)
    _setindex!(lep.c, idxs, val)
    return lep.c
end
linear_weights!(lep::AbstractMetNet, val) = linear_weights!(lep, Colon(), val) 

import MetXBase.quad_weights!
export quad_weights!
quad_weights!(lep::AbstractMetNet, rider, cider, val) =  
    (_setindex!(lep.C, rowindex(lep, rider), colindex(lep, cider), val); lep)

## -------------------------------------------------------------------
# Utils
import MetXBase.matrix_type
export matrix_type
matrix_type(::AbstractMetNet{MT, VT}) where {MT, VT} = MT

import MetXBase.vector_type
export vector_type
vector_type(::AbstractMetNet{MT, VT}) where {MT, VT} = VT