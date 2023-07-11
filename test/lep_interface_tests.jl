let
    println()
    println("="^60)
    println("LEP INTERFACE TEST")
    println("."^60)
    println()

    # Test lep interface
    net = pull_net("ecoli_core")
    
    # Fundamentals
    lep = lepmodel(net)
    @test all(colids(net) .== colids(lep))
    @test all(rowids(net) .== rowids(lep))
    
    # optionals
    @test all(stoi(net) .== cost_matrix(lep))
    @test all(balance(net) .== balance(lep))
    @test all(lb(net) .== lb(lep))
    @test all(ub(net) .== ub(lep))

end