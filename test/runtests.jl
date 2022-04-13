using DeterministicESN, Random, Printf
using Test

include("test_SCR_simple.jl")
include("test_simple_hidden_case_SCR.jl")
include("test_SCR_CRJ_equivalance.jl")

@testset "DeterministicESN.jl" begin

    @test test_SCR_simple()

    @test test_simple_hidden_case_SCR()

    @test test_SCR_CRJ_equivalance()

end
