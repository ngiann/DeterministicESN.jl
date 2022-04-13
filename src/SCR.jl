##########################################################
# Based on Rodan - minimum complexity echo state network #
##########################################################

mutable struct SCR  <: AbstractDeterministicESN

    # number of hidden neurons in reservoir
    N::Int

    # transfer function
    f

    # leaky rate
    α::Float64

    # input weight
    v::Float64

    # input bias
    b::Float64

    # hidden coupling weight
    w::Float64

    # input bias
    Vinputsigns::Array{Float64,1}

    # input weights
    V::Array{Float64,1}

    # hidden (or recurrent) weights
    Wrec::Array{Float64,2}

end


#----------------------------------------------
function SCR(; N = 100, f = tanh, seed = 1)
#----------------------------------------------

  rg = MersenneTwister(seed)

  Vinputsigns  = sign.(rand(rg, N) .- 0.5)

  Wrec  = zeros(N, N)

  V = Vinputsigns .* 0.0

  α, v, b, w = 1.0, 0.0, 0.0, 0.0

  return SCR(N, f, α, v, b, w, Vinputsigns, V, Wrec)

end



###############################################
## RETRIEVE PARAMETERS
###############################################

#----------------------------------------------
function getparameters(esn::SCR)
#----------------------------------------------

  return esn.w, esn.v, esn.b, esn.α

end

#----------------------------------------------
function getnumberofparameters(esn::SCR)
#----------------------------------------------

  return 4

end


###############################################
## SET PARAMETERS
###############################################

#----------------------------------------------
function setesn!(esn::SCR; w=w, v=v, b=b, α=1.0)
#----------------------------------------------

  esn.w, esn.v, esn.b, esn.α = w, v, b, α

  #----------------------------------------
  # set the input weight
  #----------------------------------------

  for i=1:esn.N

    esn.V[i] = esn.Vinputsigns[i] * v

  end

  #----------------------------------------
  # set the cyclic weight
  #----------------------------------------

  # see Rodan, section III.A, bullet point 3, SCR topology

  esn.Wrec[1, esn.N] = w  # upper right corner

  for n=1:esn.N-1      # lower sub diagonal

    esn.Wrec[n+1, n] = w

  end

  nothing

end





###############################################
## REPL
###############################################

#----------------------------------------------
function Base.show(io::IO, esn::SCR)
#----------------------------------------------

print(io, "SCR(N=", esn.N, ", leaky rate α = ", round(esn.α, digits=4),
                           ", coupling weight w = ", round(esn.w, digits=4),
                           ", input weight v = ", round(esn.v, digits=4),
                           ", input bias b = ", round(esn.b, digits=4),
                           ", activation function f = ", esn.f,")")

end



#**********************************************
function debug_scr()
#**********************************************

    # compare instantiated scr to hand computed scr

    net = SCR(N=5)
    setesn!(net, w = 0.1, v = 0.9, b = 0.5, α=0.2)

    hand_calculated_metrix = [0.0 0.0 0.0 0.0 0.1;
                              0.1 0.0 0.0 0.0 0.0;
                              0.0 0.1 0.0 0.0 0.0;
                              0.0 0.0 0.1 0.0 0.0;
                              0.0 0.0 0.0 0.1 0.0]

    all( hand_calculated_metrix .== net.Wrec )

end
