using MetXGEMs
using Test

@testset "MetXGEMs.jl" begin
    
    # MetNet
    include("getters_tests.jl")
    include("iders_tests.jl")
    include("net_manipulation_tests.jl")

    # TODO: Test convert COBREXA --> MetXNet
end
