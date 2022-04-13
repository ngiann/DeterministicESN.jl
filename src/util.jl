sigmoid(x) = 1.0/(1.0 + exp(-x))


leastsquares(X, y; λ=λ) = (X' * X + λ*I) \ (X' * y)


function getreadouts(esn; inputs = inputs, outputs = outputs, λ = λ)

    X = esn(inputs)

    leastsquares(X, outputs; λ = λ)

end

function getreadouts(esn, y,  λ)

    getreadouts(esn; inputs = y[1:end-1], outputs = y[2:end], λ = λ)

end

function getreadouts_and_states(esn, y,  λ)

    X = esn(y[1:end-1])

    return leastsquares(X, y[2:end]; λ = λ), X

end
