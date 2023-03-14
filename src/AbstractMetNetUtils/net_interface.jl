# A common interface for handling a MetNet-like objects
# Method to implement 
# - metnet(obj)::MetNet
# - reactions(obj)::Vector{String} accessor to reactions ids
# - metabolites(obj)::Vector{String} accessor to metabolites ids
# - genes(obj)::Vector{String} accessor to genes ids

# default for AbstractMetNet
metnet(net::AbstractMetNet) = net