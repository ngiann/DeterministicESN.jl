#---------------------------------------------------------------------------
function generatenarmadataset(NseqPer = 100, Tlength = 1000, seed = 1)
#---------------------------------------------------------------------------

		Nseq = NseqPer*3
		Y 	 = zeros(Nseq, Tlength)
		S 	 = zeros(Nseq, Tlength)

		counter = 0

		for order in [10, 20, 30]
			for index in 1:NseqPer

				auxA, auxB = createnarmaseries(order, Tlength, seed + index*order)

				counter += 1
				S[counter,:] = reshape(auxA, Tlength)
				Y[counter,:] = reshape(auxB, Tlength)

			end
		end


		labels = kron(collect(1:3), ones(NseqPer,1))

		S = [S[i,:] for i in 1:size(S, 1)]
		Y = [Y[i,:] for i in 1:size(Y, 1)]

		return Y, S, labels

end





#---------------------------------------------------------------------------
function createnarmaseries(Order, T, seed = 1)
#---------------------------------------------------------------------------

	rg = MersenneTwister(seed)

	offset = 500 # conservative offset for flushing out dependence on first arbitrary states

	T = T + offset # initial offset
	S = rand(rg, T)*0.5
	Y = zeros(T)


	if Order==10

		# 10th order NARMA system

		for t in 10:T-1
		    Y[t+1] = 0.3*Y[t] + 0.05*Y[t]*sum(Y[t.-collect(0:9)]) + 1.5*S[t-9]*S[t] + 0.1
		end

	elseif Order==20

		# 20th order NARMA system

		for t in 20:T-1
		    Y[t+1] = tanh(0.3*Y[t] + 0.05*Y[t]*sum(Y[t.-collect(0:19)]) + 1.5*S[t-19]*S[t] + 0.01) + 0.2
		end

	elseif Order==30

		# 30th order NARMA system

		for t in 30:T-1
		    Y[t+1] = 0.2*Y[t] + 0.004*Y[t]*sum(Y[t.-collect(0:29)]) + 1.5*S[t-29]*S[t] + 0.201
		end

	else

		error("Order must be either 10, 20 or 30")

	end


	# flush out dependence on initial conditions
	S = S[offset+1:end]
	Y = Y[offset+1:end]

	S = (S .- 0.5) * 2
	Y = (Y .- 0.5) * 2

	return vec(S), vec(Y)

end
