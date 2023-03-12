function lepmodel(net::AbstractMetNet) 
    net = metnet(net)
    return LEPModel(
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