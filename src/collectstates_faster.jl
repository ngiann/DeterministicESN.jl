#------------------------------------------------------------
function collectstates(esn::AbstractESN, input)
#------------------------------------------------------------

    # allocate matrix ...
    X = zeros(length(input), esn.N)

    # ... and call function that does the actual work
    collectstates!(X, esn, input)

    return X

end


#------------------------------------------------------------
function collectstates!(X, esn::AbstractESN, input)
#------------------------------------------------------------

    # initial arbitrary state of zero that should be flushed out
    x = zeros(esn.N)

    prealloc1 = zeros(esn.N)
    prealloc2 = zeros(esn.N)

    for t in 1:length(input)

        nextstep!(X, esn, input, t, x, prealloc1, prealloc2)

    end

    nothing

end


#------------------------------------------------------------
function nextstep!(X, esn::AbstractESN, input, t, x, prealloc1, prealloc2)
#------------------------------------------------------------

    prealloc1 .= esn.V.*input[t] .+ esn.b

    mul!(prealloc2, esn.Wrec, x)

    prealloc1 .+= prealloc2

    prealloc2 .= esn.f.( prealloc1 )

    prealloc2 .*= esn.α

    x .*= 1-esn.α

    x .+= prealloc2


    @inbounds for i in 1:esn.N

        X[t, i] = x[i]

    end

    nothing

end
