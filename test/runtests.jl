using DeterministicESN, Random, Printf
using Test

include("test_SCR_simple.jl")
include("test_CRJ_simple.jl")
include("test_simple_hidden_case_SCR.jl")
include("test_SCR_CRJ_equivalance.jl")
include("test_collectstates.jl")

@testset "DeterministicESN.jl" begin

    @test test_SCR_simple()

    @test test_CRJ_simple()

    @test test_simple_hidden_case_SCR()

    @test test_SCR_CRJ_equivalance()

    @test test_collectstates()

end
