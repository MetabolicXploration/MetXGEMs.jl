
# TODO: Make a full exchange discovery system
export isexchange
function topological_isexchange(net::MetNet, ider)
    reacts = rxn_reacts(net, ider)
    prods = rxn_prods(net, ider)
    return xor(isempty(reacts), isempty(prods))
end
isexchange(net::MetNet, ider) = error("To Implemenet")


export exchanges
exchanges(net::MetNet) = findall(x -> isexchange(net, x), reactions(net))
export exchangescount
exchangescount(net::MetNet) = length(exchanges(net))

# counters
export mets_count
mets_count(net::MetNet) = length(metabolites(net))

export rxns_count
rxns_count(net::MetNet) = length(reactions(net))

export genes_count
genes_count(net::MetNet) = length(genes(net))