# A common interface for handling a MetNet-like objects
# Method to implement 
# - metnet(obj)::MetNet
# - reactions(obj)::Vector{String} accessor to reactions ids
# - metabolites(obj)::Vector{String} accessor to metabolites ids
# - genes(obj)::Vector{String} accessor to genes ids

# default for AbstractMetNet



## -------------------------------------------------------------------
# net interface

export metabolites
metabolites(net::AbstractMetNet) = net.mets
metabolites(net::AbstractMetNet, ider) = net.mets[metindex(net, ider)]

export eachmets
eachmets(net) = eachindex(metabolites(net))

export reactions
reactions(net::AbstractMetNet) = net.rxns
reactions(net::AbstractMetNet, ider) = net.rxns[rxnindex(net, ider)]

export eachrxn
eachrxn(net) = eachindex(reactions(net))

export genes
genes(net::AbstractMetNet) = net.genes
genes(net::AbstractMetNet, ider) = net.genes[geneindex(net, ider)]

export eachgenes
eachgenes(net) = eachindex(genes(net))

export subsystems
subsystems(net::AbstractMetNet) = net.subSystems
subsystems(net::AbstractMetNet, ider) = net.subSystems[rxnindex(net, ider)]

export rxn_mets
rxn_mets(net::AbstractMetNet, ider) = findall(stoi(net, :,rxnindex(net, ider)) .!= 0.0)
export rxn_reacts
rxn_reacts(net::AbstractMetNet, ider) = findall(stoi(net, :,rxnindex(net, ider)) .< 0.0)
export rxn_prods
rxn_prods(net::AbstractMetNet, ider) = findall(stoi(net, :,rxnindex(net, ider)) .> 0.0)

export met_rxns
met_rxns(net::AbstractMetNet, ider) = findall(stoi(net, metindex(net, ider), :) .!= 0.0)

## -------------------------------------------------------------------
# LEP setters
export stoi!
stoi!(net::AbstractMetNet, args...) = cost_matrix!(net, args...)

## -------------------------------------------------------------------
# LEP getters
export stoi
stoi(net::AbstractMetNet, args...) = cost_matrix(net, args...)

export rxnrange
rxnrange(net::AbstractMetNet, args...) = colrange(net, args...)
