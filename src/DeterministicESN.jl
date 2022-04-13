module DeterministicESN

    using LinearAlgebra, Random

    include("AbstractDeterministicESN.jl")
    include("collectstates_faster.jl")
    include("CRJ.jl")
    include("SCR.jl")
    include("util.jl")

    export SCR, CRJ, setesn!, getparameters, getnumberofparameters, getreadouts

end
