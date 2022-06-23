#---------------------------------------------------------------------------
function createcauchy(alpha, beta; seed = 1)
#---------------------------------------------------------------------------

	rg = MersenneTwister(seed)

	lambda =  h -> (1 + abs(h).^alpha).^(-beta/alpha)

	# Generate covariance matrix
	T = -150:1:150

	Sigma = zeros(length(T), length(T))

	for (i, τ) in enumerate(T)
		for (j, ς) in enumerate(T)
			Sigma[i,j] = lambda(τ-ς)
		end
	end

	return rand(rg, MvNormal(zeros(length(T)), Sigma))

end





#---------------------------------------------------------------------------
function generatecauchydataset(N_per_class = 25)
#---------------------------------------------------------------------------


	alpha = [0.65, 1.95]
	beta  = [0.10, 0.95]



	Y = []
	count = 0
	for a in alpha
		for b in beta
			for n in 1:N_per_class
				count += 1
				push!(Y, createcauchy(a, b; seed = count))
			end
		end
	end

	labels = kron(collect(1:4), ones(N_per_class,1))

	return Y, round.(Int, vec(labels))

end
