let

    println()
    println("="^60)
    println("EchelonMetNet")
    println("."^60)
    println()

    net0 = MetXNetHub.pull_net("ecoli_core")
    enet = EchelonMetNet(net0)
    net1 = metnet(enet)
    @show size(net1)
    # DONE: test FBA (see MetXOptim)
    @test rank(net0.S) == rank(net1.S)
    @test all(net1.b .== be)
    @test all(reactions(net1) .== reactions(net0))
    @test isapprox(net1.S[:, enet.idxd],  Matrix(I, Nd, Nd); atol = 1e-5)

    println()
end