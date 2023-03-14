import Base.show
show(io::IO, m::MetNet) = (println(io, "MetNet"); summary(io, m))
