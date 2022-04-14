abstract type AbstractESN end

abstract type AbstractDeterministicESN <: AbstractESN end



###############################################
## COLLECT STATES
###############################################

function (esn::AbstractESN)(s::Array{T,1} where T<:Real)

  collectstates(esn, s)

end


function (esn::AbstractESN)(X, s::Array{T,1} where T<:Real)

  collectstates!(X, esn, s)

end


function plotesn(esn::DeterministicESN.AbstractESN)

    g = SimpleDiGraph(esn.Wrec)

    labels = Vector{String}(undef, ne(g))

    for (i, e) in enumerate(edges(g))

      weight = esn.Wrec[dst(e), src(e)] == 0 ? esn.Wrec[src(e), dst(e)] : esn.Wrec[dst(e), src(e)]

      labels[i] = repr(round(weight, digits=2))

    end

    f, ax, p = graphplot(g, elabels=labels, nlabels_color =:red, elabels_textsize=26, nlabels_textsize=35, nlabels=repr.(1:nv(g)), nlabels_align=(:center,:center))


end
