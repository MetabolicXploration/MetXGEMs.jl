function rxn_str(net::MetNet, ider; full = false)
    ridx = rxnindex(net, ider)
    arrow_str = isblocked(net, ridx) ? " >< " : 
                isbkwd_bounded(net, ridx) ? " <== " :
                isfwd_bounded(net, ridx) ? " ==> " : " <==> " 
    
    react_str = String[]
    for meti in rxn_reacts(net, ridx)
        s = stoi(net, meti, ridx)
        id = metabolites(net, meti)
        name = _getindex_or_nothing(net.metNames, meti)
        name = isnothing(name) ? "" : name
        push!(react_str, 
            full ? 
                string("(", s, ") ", id, "::[", name, "]") :
                string("(", s, ") ", id)
        )
    end
    react_str = join(react_str, " + ")

    prods_str = String[]
    for meti in rxn_prods(net, ridx)
        s = stoi(net, meti, ridx)
        id = metabolites(net, meti)
        name = _getindex_or_nothing(net.metNames, meti)
        name = isnothing(name) ? "" : name
        push!(prods_str, 
            full ? 
                string("(", s, ") ", id, "::[", name, "]") :
                string("(", s, ") ", id)
        )
    end
    prods_str = join(prods_str, " + ")
    return string(react_str,  arrow_str,  prods_str)
end
rxn_str(net::MetNet, iders::Vector; full = false) = [rxn_str(net, ider; full) for ider in iders]
rxn_str(net::MetNet; full = false) = rxn_str(net, net.rxns; full)