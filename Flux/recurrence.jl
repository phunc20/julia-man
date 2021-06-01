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

# ╔═╡ 63eda4b3-e702-4f9d-95dd-7b575397e79f
with_terminal() do
  x = rand(2)
  h = rand(5)
  for i in 1:10
	h, y = rnn(h, x)
	println("(i=", i, ") ", "y = ", y)
    #println("(i=", i, ") ", "y = $(@sprintf("%.2f", y))")
	#println("y = $(@sprintf("%.2f", y))")
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
# ╠═63eda4b3-e702-4f9d-95dd-7b575397e79f
