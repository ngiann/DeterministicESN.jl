function test_collectstates(seed=1)

    rg = MersenneTwister(seed)

    esn = SCR(N=30)

    setesn!(esn, w = 0.1, v = 0.2, b = 0.3)

    y = sin.(collect(0.1:0.1:10))



end
