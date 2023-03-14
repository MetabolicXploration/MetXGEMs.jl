# Defaults MetNet-like objects LEP interface methods implementation

import MetXBase.lepmodel
function lepmodel(net::AbstractMetNet) 
    net = metnet(net)
    return extras!!(net, :lep) do 
        LEPModel(
            net.S, 
            net.b, 
            net.lb, net.ub, 
            net.c, 
            nothing, # net.C , # TODO: Add C to MetNet?
            net.mets, 
            net.rxns, 
            net.extras
        ) 
    end
end

import MetXBase.rowids
rowids(net::AbstractMetNet) = metabolites(net)

import MetXBase.colids
colids(net::AbstractMetNet) = reactions(net)