function test_collectstates(seed=1, tol = 1e-6)

    rg = MersenneTwister(seed)

    esn = SCR(N=30)

    setesn!(esn, w = 0.1, v = 0.2, b = 0.3)

    y = sin.(collect(0.1:0.1:10))

    s = randn(rg, 10_000)

    H1 = DeterministicESN.collectstates(esn, s)
    H2 = DeterministicESN._collectstates(esn, s)

    discr = maximum(abs.(H1 - H2))

    @printf("Maximum discrepancy is %.10f\n", discr)

    discr < tol

end
