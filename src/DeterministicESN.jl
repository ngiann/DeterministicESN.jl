module DeterministicESN

    # using GLMakie
    # using GraphMakie
    using Graphs

    using LinearAlgebra, Random, Distributions, MiscUtil, Optim, Distributed

    include("AbstractDeterministicESN.jl")
    include("collectstates_faster.jl")
    include("collectstates.jl")
    include("CRJ.jl")
    include("SCR.jl")
    include("util.jl")
    include("createnarma.jl")
    include("createcauchy.jl")

    include("tuneSCRreservoir.jl")

    export SCR, CRJ, setesn!, getparameters, getnumberofparameters,
            getreadouts, get_readouts_and_states, plotesn, generatenarmadataset, generatecauchydataset,
            tuneSCRreservoir

end
