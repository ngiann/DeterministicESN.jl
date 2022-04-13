function test_SCR_simple()

    scr = SCR(N = 50)

    setesn!(scr, w = 0.1, v = 0.2, b = 0.3, α = 0.4)

    RESULT = (scr.w == 0.1) && (scr.v == 0.2) && (scr.b == 0.3) && (scr.α == 0.4) && (scr.N == 50)

    RESULT = RESULT && (abs(scr.V[1]) == 0.2 == scr.v)

    RESULT = RESULT && (scr.Wrec[1,50] == 0.1 == scr.w)

    return RESULT
end
