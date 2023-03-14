import MetXBase.reindex
function reindex(net::MetNet, metsids, rxnsids, genesids)

    # TODO: find where rxnGeneMat goes
    
    metsids = metindex(net, metsids)
    rxnsids = rxnindex(net, rxnsids)
    genesids = geneindex(net, genesids)

    netd = Dict()

    netd[:mets] = _getindex_or_nothing(net.mets, metsids)
    netd[:metNames] = _getindex_or_nothing(net.metNames, metsids)
    netd[:metFormulas] = _getindex_or_nothing(net.metFormulas, metsids)
    netd[:b] = _getindex_or_nothing(net.b, metsids)
    
    netd[:rxns] = _getindex_or_nothing(net.rxns, rxnsids)
    netd[:rxnNames] = _getindex_or_nothing(net.rxnNames, rxnsids)
    netd[:c] = _getindex_or_nothing(net.c, rxnsids)
    netd[:lb] = _getindex_or_nothing(net.lb, rxnsids)
    netd[:ub] = _getindex_or_nothing(net.ub, rxnsids)
    netd[:subSystems] = _getindex_or_nothing(net.subSystems, rxnsids)
    netd[:grRules] = _getindex_or_nothing(net.grRules, rxnsids)

    netd[:genes] = _getindex_or_nothing(net.genes, genesids)

    netd[:S] = _getindex_or_nothing(net.S, metsids, rxnsids)
    
    netd[:extras] = net.extras
    
    return  MetNet(; netd...)
end