sigmoid(x) = 1.0/(1.0 + exp(-x))


leastsquares(X, y; λ=λ) = (X' * X + λ*I) \ (X' * y)


function getreadouts(esn; inputs = inputs, outputs = outputs, λ = λ)

    X = esn(inputs)

    leastsquares(X, outputs; λ = λ)

end

function getreadouts(esn; seq = seq, λ = λ)

    getreadouts(esn; inputs = seq[1:end-1], targets = seq[2:end], λ = λ)

end
