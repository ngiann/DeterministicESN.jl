mutable struct CRJ  <: AbstractDeterministicESN

    # number of hidden neurons in reservoir
    N::Int

    # transfer function
    f

    # leaky rate
    α::Float64

    # jump length
    ℓ::Int

    # input weight
    v::Float64

    # input bias
    b::Float64

    # hidden coupling weight
    w::Float64

    # weight for jump unit
    wjump::Float64

    # number of jumps
    numjumps::Int

    # last jump unit
    lastjumpunit::Int

    # input bias
    Vinputsigns::Array{Float64,1}

    # input weights
    V::Array{Float64,1}

    # hidden (or recurrent) weights
    Wrec::Array{Float64,2}

end

#-------------------------------------------------
function CRJ(; N = 100, ℓ = 5, f = tanh, seed = 1)
#-------------------------------------------------

    # constraints on jump length
    @assert(ℓ > 1)
    @assert(ℓ < floor(N*0.5))

    rg = MersenneTwister(seed)

    Vinputsigns = sign.(rand(rg, N) .- 0.5)

    Wrec = zeros(N, N)

    V = Vinputsigns .* 0.0

    α, v, b, w, wjump = 0.0, 0.0, 0.0, 0.0, 0.0



    # Determine number of jumps and last jump

    numjumps     = 0
    lastjumpunit = 0

    # see page 6 of Rodan, Tino
    if mod(N, ℓ) == 0
        # then there are N/ℓ jumps
        numjumps = round(Int, N/ℓ)
        # Last jump is from unit N+1-ℓ to unit 1
        lastjumpunit = N+1-ℓ
    else
        # there are floor(N/ℓ) jumps
        numjumps = floor(Int, N/ℓ)
        # Last jump is from unit N+1-mod(N,ℓ) to unit 1
        lastjumpunit = N+1-mod(N,ℓ)
    end


    return CRJ(N, f, α, ℓ, v, b, w, wjump, numjumps, lastjumpunit, Vinputsigns, V, Wrec)

end


#-----------------------------------------------------------------
function setesn!(esn::CRJ; w = w, v = v, b = b, α = α, wjump = wjump)
#-----------------------------------------------------------------

    esn.wjump = wjump
    esn.w = w
    esn.v = v
    esn.α = α
    esn.b = b

    #-----------------------------------------
    # set the input weight, same as in SCR.jl
    #-----------------------------------------

    for i=1:esn.N

        esn.V[i] = esn.Vinputsigns[i] * v

    end

    #-----------------------------------------
    # set the cyclic weight, same as in SCR.jl
    #-----------------------------------------

    esn.Wrec[1, esn.N] = w  # upper right corner

    for n=1:esn.N-1      # lower sub diagonal

        esn.Wrec[n+1, n] = w

    end

    #----------------------------------------
    # Set jump entries
    #----------------------------------------

    ℓ            = esn.ℓ
    lastjumpunit = esn.lastjumpunit
    numjumps     = esn.numjumps

    # First jump is from unit 1 to unit 1+ℓ
    for j=1:numjumps-1
        esn.Wrec[1+(j-1)*ℓ, 1+j*ℓ] = wjump
        # bi-directional
        esn.Wrec[1+j*ℓ, 1+(j-1)*ℓ] = wjump
    end

    # Here we set the last jump
    if mod(esn.N, ℓ) == 0
        # Here we close the cycle, i.e. connect back to unit 1
        esn.Wrec[lastjumpunit, 1] = wjump
        # make it bi-directional
        esn.Wrec[1, lastjumpunit] = wjump
    else
        # Here we do NOT close the cycle
        esn.Wrec[lastjumpunit - numjumps, lastjumpunit] = wjump
        # make it bi-directional
        esn.Wrec[lastjumpunit, lastjumpunit - numjumps] = wjump
    end

    nothing

end




###############################################
## RETRIEVE PARAMETERS
###############################################

#----------------------------------------------
function getparameters(esn::CRJ)
#----------------------------------------------

  return esn.w, esn.v, esn.b, esn.wjump, esn.α

end

#----------------------------------------------
function getnumberofparameters(esn::CRJ)
#----------------------------------------------

  return 5

end


###############################################
## REPL
###############################################

#----------------------------------------------
function Base.show(io::IO, esn::CRJ)
#----------------------------------------------

print(io, "CRJ(N=", esn.N, ", leaky rate α = ", round(esn.α, digits=4),
                           ",\n coupling weight w = ", round(esn.w, digits=4),
                           ",\n jump length = ", esn.ℓ,
                           ",\n jump weight w = ", round(esn.wjump, digits=4),
                           ",\n number of jumps = ", esn.numjumps,
                           ",\n last jumping unit is = ", esn.lastjumpunit,
                           ",\n input weight v = ", round(esn.v, digits=4),
                           ",\n input bias b = ", round(esn.b, digits=4),
                           ",\n activation function f = ", esn.f,")")

end
