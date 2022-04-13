function test_CRJ_simple()

    crj = CRJ(N = 50)

    setesn!(crj, w = 0.1, v = 0.2, b = 0.3, α = 0.4, wjump = 0.5)

    RESULT = (crj.w == 0.1) && (crj.v == 0.2) && (crj.b == 0.3) && (crj.α == 0.4) && (crj.N == 50)  && (crj.wjump == 0.5)

    RESULT = RESULT && (abs(crj.V[1]) == 0.2 == crj.v)

    RESULT = RESULT && (crj.Wrec[1,50] == 0.1 == crj.w)

    return RESULT
end
