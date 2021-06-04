### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 0b00fb7e-c2e8-11eb-1436-fd6336b8f865
begin
  using Pkg
  Pkg.activate(Base.Filesystem.homedir() * "/.config/julia/projects/oft")
end

# ╔═╡ 67d1995d-fb24-4fb9-85df-b4b7c016536b
using Flux 

# ╔═╡ a622d489-12e6-4421-9b5c-994b7281e199
using Random

# ╔═╡ c36cb7c3-fdbd-4e59-88c3-b09b3853b398
begin
  using PlutoUI
  using Printf
end

# ╔═╡ 507931a9-26b6-475a-9ee2-6e7c779dfe4f
md"""
# Recurrent Neural Networks
> What distinguishes an RNN from a simple DNN is that aside from the input, its
> neuron or its layer of neurons takes as input the **hidden state** from the
> previous step.
"""

# ╔═╡ 3e90afbd-e99a-4fb4-88c2-50e700449c87
md"""
The most basic memory cell: The output simply equals the hidden state.
"""

# ╔═╡ 9bc57528-e5d4-445b-a125-e46170b68e41
begin
  Random.seed!(42)
  Wxh = randn(5, 2)
  Whh = randn(5, 5)
  b   = randn(5)
  
  function rnn(h, x)
    h = tanh.(Wxh * x .+ Whh * h .+ b)
    y = h
    return h, y
  end
  
  x = rand(2) # dummy data
  h = rand(5)  # initial hidden state
  
  h, y = rnn(h, x)
  h == y
end

# ╔═╡ 2616428d-d0eb-4bff-8591-5d1cd0516e4e
h .== y

# ╔═╡ bc5b80e9-a774-401b-8a55-219774bb4760
md"""
> Notice how the above is essentially a `Dense` layer.

Indeed,
``W_{x, h} x + W_{h, h}h = [W_{x, h}|W_{h, h}] ``
"""

# ╔═╡ 8cbd3adc-4070-42b5-b39d-ea65ad57b8c0
h

# ╔═╡ 6af8a13d-b70a-4fc0-88a2-b08402ab1981
Base.show(io::IO, f::Float64) = @printf(io, "%.2f", f)

# ╔═╡ 63eda4b3-e702-4f9d-95dd-7b575397e79f
with_terminal() do
  x = rand(2)
  h = rand(5)
  for i in 1:7
	h, y = rnn(h, x)
	#println("(i=", i, ") ", "y = ", y)
	println("(i=", @sprintf("%2d", i), ") ", " y = ", y)
  end
end

# ╔═╡ 2a68bb7e-13d3-4130-a26e-848dbad04e90
Flux.RNNCell, Flux.LSTMCell, Flux.GRUCell

# ╔═╡ b12926dd-befa-41c7-8e8b-718cc93ccf00
begin
  rnn_cell = Flux.RNNCell(2, 5)
  lstm_cell = Flux.LSTMCell(2, 5)
  gru_cell = Flux.GRUCell(2, 5)
end

# ╔═╡ 42c25ecb-4325-4ee8-b4e9-4e355b00bfcb
with_terminal() do
  x = rand(Float32, 2)
  h = rand(Float32, 5)
  for i in 1:5
	h, y = rnn_cell(h, x)
	println("(i=", @sprintf("%2d", i), ")\n", "y = ", y, "\nh = ", h)
  end
end

# ╔═╡ 67563e32-e189-4aa4-809e-39b3b8c8aa65
md"""
**(?)** Why the same code does not work for `LSTMCell`?

"""

# ╔═╡ f8f65c09-ce6c-4516-9be4-35dd715cf263
# with_terminal() do
#  x = rand(Float32, 2)
#  h = rand(Float32, 5)
#  for i in 1:5
# 	h, y = lstm_cell(h, x)
# 	println("(i=", @sprintf("%2d", i), ")\n", "y = ", y, "\nh = ", h)
#  end
# end

# ╔═╡ d924f58e-fb7f-43c1-8226-e229435f998a
with_terminal() do
  x = rand(Float32, 2)
  h = rand(Float32, 5)
  for i in 1:5
	h, y = gru_cell(h, x)
	println("(i=", @sprintf("%2d", i), ")\n", "y = ", y, "\nh = ", h)
  end
end

# ╔═╡ Cell order:
# ╟─507931a9-26b6-475a-9ee2-6e7c779dfe4f
# ╠═0b00fb7e-c2e8-11eb-1436-fd6336b8f865
# ╠═67d1995d-fb24-4fb9-85df-b4b7c016536b
# ╟─3e90afbd-e99a-4fb4-88c2-50e700449c87
# ╠═a622d489-12e6-4421-9b5c-994b7281e199
# ╠═9bc57528-e5d4-445b-a125-e46170b68e41
# ╠═2616428d-d0eb-4bff-8591-5d1cd0516e4e
# ╠═bc5b80e9-a774-401b-8a55-219774bb4760
# ╠═c36cb7c3-fdbd-4e59-88c3-b09b3853b398
# ╠═8cbd3adc-4070-42b5-b39d-ea65ad57b8c0
# ╠═6af8a13d-b70a-4fc0-88a2-b08402ab1981
# ╠═63eda4b3-e702-4f9d-95dd-7b575397e79f
# ╠═2a68bb7e-13d3-4130-a26e-848dbad04e90
# ╠═b12926dd-befa-41c7-8e8b-718cc93ccf00
# ╠═42c25ecb-4325-4ee8-b4e9-4e355b00bfcb
# ╟─67563e32-e189-4aa4-809e-39b3b8c8aa65
# ╠═f8f65c09-ce6c-4516-9be4-35dd715cf263
# ╠═d924f58e-fb7f-43c1-8226-e229435f998a
