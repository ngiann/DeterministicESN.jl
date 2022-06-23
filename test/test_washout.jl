#**********************************************
function test_washout()
#**********************************************

    scr = SCR(N = 40)

    setesn!(scr, α = 0.9, w = 0.1, v = 0.2, b = 0.3)

    rg = MersenneTwister(101)

    input = randn(rg, 131)

    W1, X1 = get_readouts_and_states(scr, input,  0.1, 0)
    W2, X2 = get_readouts_and_states(scr, input,  0.1, 1)
    W3, X3 = get_readouts_and_states(scr, input,  0.1, 13)

    R1 = all(X1[20].== X2[19]) && all(X1[20].== X3[7])

    R2 = (size(X1,2) == size(X2,2)) && (size(X1,2) == size(X3,2))

    R3 = (size(X1,1) == size(X2,1)+1) && (size(X1,1) == size(X3,1)+13)

    R4 = all(size(W1) .== size(W2)) && all(size(W1) .== size(W3))

    return R1 && R2 && R3 && R4

end
