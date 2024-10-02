using RunTestsEnv
@activate_testenv

using Test
using MetXBase
using MetXGEMs
using MetXNetHub
using LinearAlgebra

import Random
Random.seed!(1234)

@testset "MetXGEMs.jl" begin
    
    # MetNet
    include("getters_tests.jl")
    include("io_tests.jl")
    include("ider_interface_tests.jl")
    include("lep_interface_tests.jl")
    include("net_manipulation_tests.jl")

end
