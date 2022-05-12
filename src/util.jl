sigmoid(x) = 1.0/(1.0 + exp(-x))


leastsquares(X, y; λ=λ) = (X' * X + λ*I) \ (X' * y)


function getreadouts(esn; inputs = inputs, outputs = outputs, λ = λ, washout = 0)

    X = esn(inputs)

    leastsquares(X[washout+1:end,:], outputs[washout+1:end]; λ = λ)

end


function getreadouts(esn, y,  λ, washout::Int)

    getreadouts(esn; inputs = y[1:end-1], outputs = y[2:end], λ = λ, washout = washout)

end


function get_readouts_and_states(esn, y,  λ, washout::Int)

    inputs, outputs  = y[1:end-1], y[2:end]

    X = esn(inputs)[washout+1:end,:]

    leastsquares(X, outputs[washout+1:end]; λ = λ), X

end
