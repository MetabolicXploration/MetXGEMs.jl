metnet(echnet::EchelonMetNet) = echnet.net

for fun in [:reactions, :metabolites, :genes]
    @eval $(fun)(echnet::EchelonMetNet, args...) = $(fun)(metnet(echnet), args...)
end