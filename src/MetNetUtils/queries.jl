export isreversible
isreversible(net::MetNet, ider) = (indx = rxnindex(net, ider); 
            lb(net)[indx] < 0.0 && ub(net)[indx] > 0.0)

export isblocked
isblocked(net::MetNet, ider) = (indx = rxnindex(net, ider); 
    lb(net)[indx] == 0.0 && ub(net)[indx] == 0.0)

import Base.isopen
export isopen
isopen(net::MetNet, ider) = !isblocked(net, ider)

export isfwd_bounded
isfwd_bounded(net::MetNet, ider) = (indx = rxnindex(net, ider); 
    lb(net)[indx] >= 0.0 && ub(net)[indx] > 0.0)

export isbkwd_bounded
isbkwd_bounded(net::MetNet, ider) = (indx = rxnindex(net, ider); 
    lb(net)[indx] < 0.0 && ub(net)[indx] <= 0.0)

export isfwd_defined
isfwd_defined(net::MetNet, ider) = (indx = rxnindex(net, ider); 
    length(rxn_reacts(net, indx)) > 0)

export isbkwd_defined
isbkwd_defined(net::MetNet, ider) = (indx = rxnindex(net, ider); 
    length(rxn_prods(net, indx)) > 0) 

export isfixxed
isfixxed(net::MetNet, ider) = (indx = rxnindex(net, ider); 
    lb(net)[indx] == ub(net)[indx] != 0.0)

export reversibles
reversibles(net::MetNet) = findall((lb(net) .< 0.0) .& (ub(net) .> 0.0))
export revscount
revscount(net::MetNet) = length(reversibles(net))

export blocks
blocks(net::MetNet) = findall((lb(net) .== 0.0) .& (ub(net) .== 0.0))
export blockscount
blockscount(net::MetNet) = length(blocks(net))

export fwds_bounded
fwds_bounded(net::MetNet) = findall((lb(net) .>= 0.0) .& (ub(net) .> 0.0))
export fwds_boundedcount
fwds_boundedcount(net::MetNet) = length(fwds_bounded(net))

export bkwds_bounded
bkwds_bounded(net::MetNet) = findall((lb(net) .< 0.0) .& (ub(net) .<= 0.0))
export bkwds_boundedcount
bkwds_boundedcount(net::MetNet) = length(bkwds_bounded(net))

export fixxeds
fixxeds(net::MetNet) = findall((lb(net) .== ub(net) .&& lb(net) .!= 0.0))
export fixxedscount
fixxedscount(net::MetNet) = length(fixxeds(net))

export allfwd
allfwd(net::MetNet) = fwds_boundedcount(net) == rxnscount(net)

# TODO: Make a full exchange discovery system
export isexchange
function isexchange(net::MetNet, ider)
    reacts = rxn_reacts(net, ider)
    prods = rxn_prods(net, ider)
    return xor(isempty(reacts), isempty(prods))
end
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