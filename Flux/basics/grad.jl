### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 8ce76b60-8197-11eb-2ba0-1fbd56efda05
using Flux

# ╔═╡ 87e0fa16-8195-11eb-1390-1740676ce3a0
path_tmp = mktempdir()

# ╔═╡ db37122a-8197-11eb-1cbf-29fc1bcadf1f
typeof(path_tmp)

# ╔═╡ 8d070ed4-8197-11eb-1ca9-f5354be2ffbd
#begin
#  using Pkg
#  Pkg.activate(path_tmp)
#  Pkg.add([
#    "Flux"
#  ])
#end

# ╔═╡ 814b60ca-8199-11eb-36f6-8f46f90b8b4f
f(x) = 3x^2 + 2x + 1

# ╔═╡ b32bb1e4-8199-11eb-3a2b-5b84551b25fc
∇f(x) = gradient(f, x)[1]  # df/dx = 6x + 2

# ╔═╡ b9a7ef06-8199-11eb-3b2b-3165fb901f3f
typeof(gradient(f, x))

# ╔═╡ d264a2fa-8199-11eb-04f6-f7a0de43eadd
typeof(f)

# ╔═╡ 8b10377e-819f-11eb-2192-a7e3752fca70


# ╔═╡ ef711a12-819d-11eb-074d-897cd7b3f324


# ╔═╡ Cell order:
# ╠═87e0fa16-8195-11eb-1390-1740676ce3a0
# ╠═db37122a-8197-11eb-1cbf-29fc1bcadf1f
# ╠═8d070ed4-8197-11eb-1ca9-f5354be2ffbd
# ╠═8ce76b60-8197-11eb-2ba0-1fbd56efda05
# ╠═814b60ca-8199-11eb-36f6-8f46f90b8b4f
# ╠═b32bb1e4-8199-11eb-3a2b-5b84551b25fc
# ╠═b9a7ef06-8199-11eb-3b2b-3165fb901f3f
# ╠═d264a2fa-8199-11eb-04f6-f7a0de43eadd
# ╠═8b10377e-819f-11eb-2192-a7e3752fca70
# ╟─ef711a12-819d-11eb-074d-897cd7b3f324
