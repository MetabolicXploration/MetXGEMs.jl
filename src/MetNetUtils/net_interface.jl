## -------------------------------------------------------------------
# net interface

export metabolites
metabolites(net::MetNet) = net.mets
metabolites(net::MetNet, ider) = net.mets[metindex(net, ider)]

export eachmets
eachmets(net) = eachindex(metabolites(net))

export reactions
reactions(net::MetNet) = net.rxns
reactions(net::MetNet, ider) = net.rxns[rxnindex(net, ider)]

export eachrxn
eachrxn(net) = eachindex(reactions(net))

export genes
genes(net::MetNet) = net.genes
genes(net::MetNet, ider) = net.genes[geneindex(net, ider)]

export eachrxn
eachgenes(net) = eachindex(genes(net))

export rxn_mets
rxn_mets(net::MetNet, ider) = findall(stoi(net, :,rxnindex(net, ider)) .!= 0.0)
export rxn_reacts
rxn_reacts(net::MetNet, ider) = findall(stoi(net, :,rxnindex(net, ider)) .< 0.0)
export rxn_prods
rxn_prods(net::MetNet, ider) = findall(stoi(net, :,rxnindex(net, ider)) .> 0.0)

export met_rxns
met_rxns(net::MetNet, ider) = findall(stoi(net, metindex(net, ider), :) .!= 0.0)

## -------------------------------------------------------------------
# LEP setters
export stoi!
stoi!(net::MetNet, args...) = cost_matrix!(net, args...)

## -------------------------------------------------------------------
# LEP getters
export stoi
stoi(net::MetNet, args...) = cost_matrix(net, args...)

export rxnrange
rxnrange(net, args...) = colrange(net, args...)

## -------------------------------------------------------------------
# Utils
export matrix_type
matrix_type(::MetNet{MT, VT}) where {MT, VT} = MT
export vector_type
vector_type(::MetNet{MT, VT}) where {MT, VT} = VT
