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

    for t in 1:length(input)

        nextstep!(X, esn, input, t, x)

    end

    nothing

end


#------------------------------------------------------------
function nextstep!(X, esn::AbstractESN, input, t, x)
#------------------------------------------------------------

    x .= esn.α * esn.f.( (esn.Wrec * x)  .+  (esn.V*input[t] .+ esn.b) ) .+ (1-esn.α) * x

    for i in 1:esn.N

        X[t, i] = x[i]

    end

    nothing

end
