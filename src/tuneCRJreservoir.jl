function tuneCRJreservoir(inputs, targets; parallel = false, iterations = 10, reservoirsize = 100, ℓ = 10, split = 0.5, washout = 20)


    # make sure there are as many inputs as targets

    N = length(inputs); @assert(length(inputs) == length(targets))

    # make sure the lengths of the individual inputs are equal to the lengths 
    # of the individual target lengths

    @assert(all(length.(inputs) .== length.(targets)))

    # instantiate esn

    esn = CRJ(N = reservoirsize, ℓ = ℓ)


    #-----------------------------------------------------------------
    # Convert unconstrained parameters to valid constrained parameters
    #-----------------------------------------------------------------

    function unpack(params)

        local w     = transformbetween(params[1], 0.0,  1.0)

        local v     = transformbetween(params[2], 0.0,  1.0)

        local b     =                  params[3]

        local wjump = transformbetween(params[4], 0.0,  1.0)

        local α     = transformbetween(params[5], 0.0,  1.0)

        local λ     = transformbetween(params[6], 1e-8, 1.0)

        return w, v, b, wjump, α, λ

    end

    #-----------------------------------------------------------------
    # Objective based on predicting unseen part of sequence
    #-----------------------------------------------------------------

    function singlesequenceobjective(input, target, λ)

        @assert(length(input) == length(target))

        local train_input, train_target, test_input, test_target = splitsequence(input, target)

        local W = getreadouts(esn; inputs = train_input, outputs = train_target, λ = λ, washout = washout)

        # get predictions on test data

        local Xtest = esn(test_input)

        local prediction = vec(Xtest * W)

        sum((test_target[washout+1:end] - prediction[washout+1:end]).^2)


    end


    function objective(params)

        local fitness = 0.0

        local w, v, b, wjump, α, λ = unpack(params)

        # set parameters esn

        setesn!(esn; w = w, v = v, b = b, α = α, wjump = wjump)

        parallel ? sum(pmap((x, y) -> singlesequenceobjective(x, y, λ), inputs, targets)) : sum(map((x, y) -> singlesequenceobjective(x, y, λ), inputs, targets))

    end


    #-----------------------------------------------------------------
    # Split sequence to training and testing part
    #-----------------------------------------------------------------

    function splitsequence(input, target)

        @assert(length(input) == length(target))

        local mark = ceil(Int, length(input) * split)

        input[1:mark],  target[1:mark],  input[1+mark:end],  target[1+mark:end]
    
    end


    #-----------------------------------------------------------------
    # Setup and call optimiser
    #-----------------------------------------------------------------

    opt = Optim.Options(iterations = iterations, show_trace = true, show_every = 1)

    initsol = randn(6)

    display(unpack(initsol))

    result = optimize(objective, initsol, NelderMead(), opt)

    let 

        w, v, b, wjump, α, λ = unpack(result.minimizer)
        
        setesn!(esn; w = w, v = v, b = b, α = α, wjump = wjump)

    end

    return esn

end