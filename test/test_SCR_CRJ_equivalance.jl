function test_SCR_CRJ_equivalance(seed = 1, tol = 1e-6)

    rg = MersenneTwister(seed)

    scr = SCR(N = 50)

    crj = CRJ(N = 50)

    setesn!(scr, w = 0.1, v = 0.2, b = 0.3)

    setesn!(crj, w = 0.1, v = 0.2, b = 0.3, wjump = 0)

    x = randn(rg, 10000)

    discr = maximum(abs.(crj(x) .- scr(x)))

    @printf("Maximum discrepancy is %.10f\n", discr)

    discr < tol


end
