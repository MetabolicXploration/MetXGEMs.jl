import MetXBase.search
search(net::MetNet, hint, fields = [:rxns, :mets, :rxnNames, :metNames, :genes]; kwargs...) =
    search((x) -> false, net, hint, fields; kwargs...)