let
    println()
    println("="^60)
    println("IO TEST")
    println("."^60)
    println()

    # setup
    test_dir = tempdir()
    mkpath(test_dir)
    
    # net0
    lep0 = toy_model(MetNet) |> lepmodel
    
    for ext in [".mat", 
        # ".xml", # TODO: Check why this error (COBREXA related)
        ".json"]
        
        fn = joinpath(test_dir, string("test_net", ext))
        @show basename(fn)
        try
            rm(fn; force = true)
            # save
            save_net(lep0, fn)
            @test isfile(fn)
            
            # load
            lep1 = load_net(fn)

            # Test LEP fields
            @test all(colids(lep0) .== colids(lep1))
            @test all(rowids(lep0) .== rowids(lep1))
            @test all(cost_matrix(lep0) .== cost_matrix(lep1))
            @test all(balance(lep0) .== balance(lep1))
            @test all(lb(lep0) .== lb(lep1))
            @test all(ub(lep0) .== ub(lep1))
        finally
            rm(fn; force = true)
        end

    end

    println()
end
