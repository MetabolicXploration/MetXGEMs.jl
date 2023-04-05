# LEPModel
import Base.size
size(net::AbstractMetNet, args...) = size(lepmodel(net), args...)

import Base.==
function ==(lep1::AbstractMetNet, lep2::AbstractMetNet)
    return lepmodel(lep1) == lepmodel(lep2)
end

import Base.isequal
isequal(lep1::AbstractMetNet, lep2::AbstractMetNet) = (lep1 == lep2)

import Base.big
function Base.big(net::AbstractMetNet)
    lep = LEPModel(net; 
        S = _collect_or_nothing(BigFloat, net.S),
        b = _collect_or_nothing(BigFloat, net.b), 
        lb = _collect_or_nothing(BigFloat, net.lb), 
        ub = _collect_or_nothing(BigFloat, net.ub), 
        c = _collect_or_nothing(BigFloat, net.c), 
        C = _collect_or_nothing(BigFloat, net.C) 
    )
    return MetNet(net, lep)
end

import Base.hash
function hash(net::AbstractMetNet, h::UInt64 = UInt64(0)) 
    h += hash(nameof(typeof(net)))
    hash(lepmodel(net), h)
end
hash(net::AbstractMetNet, h::Integer) = hash(net, UInt64(h)) 

import Base.show
show(io::IO, net::AbstractMetNet) = println(io, nameof(typeof(net)), " ", size(net))