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
