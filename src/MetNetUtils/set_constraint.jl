import MetXBase.set_constraint!
function set_constraint!(net::MetNet, colid;
        S = nothing,
        lb = nothing,
        ub = nothing,
    )

    # col stuf
    rxn_idx = findindex_or_empty_spot(net, reactions, colid)
    _setindex_or_nothing!(net.rxns, rxn_idx, colid)
    _setindex_or_nothing!(net.c, rxn_idx, 0.0)
    isnothing(lb) || _setindex_or_nothing!(net.lb, rxn_idx, lb)
    isnothing(ub) || _setindex_or_nothing!(net.ub, rxn_idx, ub)

    # row x col stuf
    isnothing(S) || for (met_id, s) in S
        row_idx = findindex_or_empty_spot(net, metabolites, met_id)
        _setindex_or_nothing!(net.mets, row_idx, met_id)
        _setindex_or_nothing!(net.b, row_idx, 0.0)

        _setindex_or_nothing!(net.S, row_idx, rxn_idx, s)
        # _setindex_or_nothing!(net.C, row_idx, rxn_idx, 0.0)
    end

    return net
end