sigmoid(x) = 1.0/(1.0 + exp(-x))

split(y) = (input=y[1:end-1], output=y[2:end])

leastsquares(X, y; λ=λ) = (X' * X + λ*I) \ (X' * y)


function getreadouts(esn; input = input, output = output, λ = λ, washout = 0)

    X = esn(input)

    leastsquares(X[washout+1:end,:], output[washout+1:end]; λ = λ)

end


function getreadouts(esn, y,  λ, washout::Int)

    input, output  = split(y)

    getreadouts(esn; input = y[1:end-1], output = y[2:end], λ = λ, washout = washout)

end


function get_readouts_and_states(esn, y,  λ, washout::Int)

    input, output  = split(y)

    X = esn(input)[washout+1:end,:]

    leastsquares(X, output[washout+1:end]; λ = λ), X

end