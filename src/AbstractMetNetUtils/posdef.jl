## ---------------------------------------------------
# TODO: make all rxns to produce a fwd and bwd rxns for homogeneity
# it is not important that some are blocked
import MetXBase.posdef
function posdef(net0::AbstractMetNet; ignore = (rxn) -> false)
    
    # Add nutrient uptake reations
    net1 = resize(net0; 
        nrxns = 2 * size(net0, 2)
    )
    
    for (rxni, rxn0) in enumerate(reactions(net0))
        ignore(rxn0) === true && continue
        
        # common stuff
        # idx
        fwd_rxni = rxni
        bwd_rxni = findfirst_empty_spot(net1, colids)
        @assert !isnothing(bwd_rxni)
        
        # id
        fwd_rxn = string("FWD_", rxn0)
        net1.rxns[fwd_rxni] = fwd_rxn
        bwd_rxn = string("BWD_", rxn0)
        net1.rxns[bwd_rxni] = bwd_rxn
        # S
        fwd_s = cost_matrix(net0, :, fwd_rxni)
        cost_matrix!(net1, :, bwd_rxni, -1 .* fwd_s)
        # rest
        MetXGEMs._merge_rxninfo!(net1, bwd_rxn, net0, rxn0)

        # Bounds
        # Case I
        l, u = bounds(net0, fwd_rxni)
        if l <= 0 && u >= 0
            bounds!(net1, fwd_rxni, 0, u)
            bounds!(net1, bwd_rxni, 0, -l)
            continue
        end
        # Case II
        if l < 0 && u < 0
            bounds!(net1, fwd_rxni, 0, 0)
            bounds!(net1, bwd_rxni, -u, -l)
            continue
        end
        # Case III
        if l > 0 && u > 0
            bounds!(net1, fwd_rxni, l, u)
            bounds!(net1, bwd_rxni, 0, 0)
            continue
        end

    end

    return has_empty_col(net1) ? emptyless_model(net1) : net1

    # for (rxni, rxn) in enumerate(reactions(net0))
    #     ignore(rxn) === true && continue

    #     l, u = bounds(net0, rxni)
        
    #     # noop
    #     l >= 0 && u > 0 && continue

    #     # Flip cases
    #     if l < 0 && u <= 0
    #         net1.rxns[rxni] = string("REV_", rxn)
    #         s = cost_matrix(net0, :, rxni)
    #         cost_matrix!(net1, :, rxni, -1 .* s)
    #         lb!(net1, rxni, -u)
    #         ub!(net1, rxni, -l)
    #         continue
    #     end
        
    #     # Split cases
    #     if l < 0 && u > 0
    #         # frd
    #         net1.rxns[rxni] = string("FWD_", rxn)
    #         lb!(net1, rxni, 0)
            
    #         # back
    #         # back
    #         # rev_rxni = findfirst_empty_spot(net1, colids)
    #         rev_rxni = findfirst_empty_spot(net1, colids)
    #         @assert !isnothing(rev_rxni)
    #         rev_rxn = string("BWD_", rxn)
    #         net1.rxns[rev_rxni] = rev_rxn
    #         s = cost_matrix(net0, :, rxni)
    #         cost_matrix!(net1, :, rev_rxni, -1 .* s)
    #         lb!(net1, rev_rxni, 0)
    #         ub!(net1, rev_rxni, -1 * l)
    #         MetXGEMs._merge_rxninfo!(net1, rev_rxn, net0, rxn)
    #         continue
    #     end
    # end

    # return net1
end