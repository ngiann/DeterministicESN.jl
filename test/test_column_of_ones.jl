function test_column_of_ones()

  crj = CRJ(N = 50)

  setesn!(crj, w = 0.1, v = 0.2, b = 0.3, α = 0.4, wjump = 0.5)

  x = randn(100)

  H1 = crj(x)

  RESULT = all(H1[:,51] .== 1.0)

  #---------------------

  scr = SCR(N = 50)

  setesn!(scr, w = 0.1, v = 0.2, b = 0.3, α = 0.4)

  x = randn(100)

  H2 = scr(x)

  RESULT = RESULT && all(H1[:,51] .== 1.0)

  return RESULT

end
