# A common interface for handling a MetNet-like objects
# Method to implement 
# - metnet(obj)::MetNet
# - reactions(obj)::Vector{String} accessor to reactions ids
# - metabolites(obj)::Vector{String} accessor to metabolites ids
# - genes(obj)::Vector{String} accessor to genes ids

# default for AbstractMetNet



## -------------------------------------------------------------------
# net interface

metabolites(net::AbstractMetNet) = net.mets
metabolites(net::AbstractMetNet, ider) = net.mets[metindex(net, ider)]

eachmets(net) = eachindex(metabolites(net))

reactions(net::AbstractMetNet) = net.rxns
reactions(net::AbstractMetNet, ider) = net.rxns[rxnindex(net, ider)]

eachrxn(net) = eachindex(reactions(net))

genes(net::AbstractMetNet) = net.genes
genes(net::AbstractMetNet, ider) = net.genes[geneindex(net, ider)]

eachgenes(net) = eachindex(genes(net))

subsystems(net::AbstractMetNet) = net.subSystems
subsystems(net::AbstractMetNet, ider) = net.subSystems[rxnindex(net, ider)]

rxn_mets(net::AbstractMetNet, ider) = col_nzcost(net, ider)
rxn_reacts(net::AbstractMetNet, ider) = col_negcost(net, ider)
rxn_prods(net::AbstractMetNet, ider) = col_poscost(net, ider)

met_rxns(net::AbstractMetNet, ider) = row_nzcost(net, ider)
met_consumers(net::AbstractMetNet, ider) = row_negcost(net, ider)
met_producers(net::AbstractMetNet, ider) = row_poscost(net, ider)

## -------------------------------------------------------------------
# LEP setters
stoi!(net::AbstractMetNet, args...) = cost_matrix!(net, args...)

## -------------------------------------------------------------------
# LEP getters
stoi(net::AbstractMetNet, args...) = cost_matrix(net, args...)

rxnrange(net::AbstractMetNet, args...) = colrange(net, args...)


## ------------------------------------------------------------
function _merge_metinfo!(dest_net1, id1, src_net2, id2)
    meti1 = metindex(dest_net1, id1)
    meti2 = metindex(src_net2, id2)
    
    for f in [:metNames, :metFormulas]
        val2 = _getindex_or_nothing(getfield(src_net2, f), meti2)
        isnothing(val2) || _setindex_or_nothing!(
            getfield(dest_net1, f), meti1, val2
        )
    end
end

function _merge_rxninfo!(dest_net1, id1, src_net2, id2)
    rxni1 = rxnindex(dest_net1, id1)
    rxni2 = rxnindex(src_net2, id2)
    
    for f in [:subSystems, :rxnNames]
        val2 = _getindex_or_nothing(getfield(src_net2, f), rxni2)
        isnothing(val2) || _setindex_or_nothing!(
            getfield(dest_net1, f), rxni1, val2
        )
    end
end
