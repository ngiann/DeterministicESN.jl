using DeterministicESN, Random, Printf
using Test

include("test_SCR_simple.jl")
include("test_CRJ_simple.jl")
include("test_simple_hidden_case_SCR.jl")
include("test_SCR_CRJ_equivalance.jl")
include("test_collectstates.jl")
include("test_column_of_ones.jl")
include("test_washout.jl")

@testset "DeterministicESN.jl" begin

    @test test_SCR_simple()

    @test test_CRJ_simple()

    @test test_simple_hidden_case_SCR()

    @test test_SCR_CRJ_equivalance()

    @test test_collectstates()

    @test test_column_of_ones()

    @test test_washout()

end
