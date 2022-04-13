#------------------------------------------------------------
function _collectstates(esn::AbstractESN, input)
#------------------------------------------------------------

    # allocate matrix ...
    X = ones(length(input), esn.N+1)

    # ... and call function that does the actual work
    _collectstates!(X, esn, input)

    return X

end


#------------------------------------------------------------
function _collectstates!(X, esn::AbstractESN, input)
#------------------------------------------------------------

    # initial arbitrary state of zero that should be flushed out
    x = zeros(esn.N)

    for t in 1:length(input)

        _nextstep!(X, esn, input, t, x)

    end

    nothing

end


#------------------------------------------------------------
function _nextstep!(X, esn::AbstractESN, input, t, x)
#------------------------------------------------------------

    x .= esn.α * esn.f.( (esn.Wrec * x)  .+  (esn.V*input[t] .+ esn.b) ) .+ (1-esn.α) * x

    for i in 1:esn.N

        X[t, i] = x[i]

    end

    nothing

end
