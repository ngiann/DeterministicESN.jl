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

      labels[i] = repr(round(esn.Wrec[dst(e), src(e)], digits=3))

    end

    f, ax, p = graphplot(g, elabels=labels, nlabels_color =:red, elabels_textsize=26, nlabels_textsize=35, nlabels=repr.(1:nv(g)), nlabels_align=(:center,:center))


end
