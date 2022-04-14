module DeterministicESN

    using GLMakie
    using GraphMakie
    using Graphs

    using LinearAlgebra, Random

    include("AbstractDeterministicESN.jl")
    include("collectstates_faster.jl")
    include("collectstates.jl")
    include("CRJ.jl")
    include("SCR.jl")
    include("util.jl")

    export SCR, CRJ, setesn!, getparameters, getnumberofparameters,
            getreadouts, getreadouts_and_states, plotesn

end
