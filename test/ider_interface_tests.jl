let
    println()
    println("="^60)
    println("IDER INTERFACE TEST")
    println("."^60)
    println()

    net = toy_model(MetNet)

    for (i, rxn) in enumerate(reactions(net))
        @test rxnindex(net, i) == i
        @test rxnindex(net, rxn) == i
    end

    for (i, met) in enumerate(metabolites(net))
        @test metindex(net, i) == i
        @test metindex(net, met) == i
    end

    @test_throws ErrorException metindex(net, "met_not_in_model")
    @test_throws ErrorException rxnindex(net, "rxn_not_in_model")

    println()
end