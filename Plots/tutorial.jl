### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ ed2af656-710a-11eb-24fa-81a3d593ac69
begin
	using Pkg
	Pkg.add("Plots")
end

# ╔═╡ ce59929e-7109-11eb-1054-eb9b5c5f5acc
using Plots

# ╔═╡ d6cb9ec2-710c-11eb-07e3-ef419eac13fe
theme(:dark)

# ╔═╡ 4c259ae4-710b-11eb-3019-9f2260ab2455
begin
  x = 1:10; y = rand(10);
  plot(x, y)
end

# ╔═╡ 33b73896-710e-11eb-0124-232e6af2e301
md"""
Each column of `y` is a graph corresponding to `x`.
"""

# ╔═╡ 1ebf9a8e-710c-11eb-3263-23c54d60fad5
x1 = 1:10; y1 = rand(10, 2)  # 2 columns \implies 2 graphs

# ╔═╡ edab313a-710b-11eb-0f32-09d5d56c4dfa
plot(x1, y1)

# ╔═╡ ed74d3e2-710b-11eb-281a-2d137ab134f3
z1 = rand(10)

# ╔═╡ ed36db50-710b-11eb-2098-61c05cc88ea2
plot!(x1, z1)

# ╔═╡ 5c9cb590-710d-11eb-0c59-0b40190a84b0
Plots.CURRENT_PLOT

# ╔═╡ 4d664d48-710d-11eb-0670-43534108df9d
begin
  w1 = rand(10)
  plot!(Plots.CURRENT_PLOT, x1, w1)
end

# ╔═╡ bc0f7f62-710d-11eb-1b99-5dc338cbf054
x2 = 1:10; y2 = rand(10,2)

# ╔═╡ 132cff22-710e-11eb-2733-7db2bce67320
md"""
We can use a variable to capture the return value of `plot()` for later usage.

"""

# ╔═╡ bba16fae-710d-11eb-3a19-6d0f5c43a13e
p = plot(x2,y2)

# ╔═╡ bb4f43be-710d-11eb-1eb0-1b567145820a
z2 = rand(10)

# ╔═╡ eba11678-710d-11eb-0116-eb8cd0c012ac
plot!(p, x2, z2)

# ╔═╡ Cell order:
# ╠═ed2af656-710a-11eb-24fa-81a3d593ac69
# ╠═ce59929e-7109-11eb-1054-eb9b5c5f5acc
# ╠═d6cb9ec2-710c-11eb-07e3-ef419eac13fe
# ╠═4c259ae4-710b-11eb-3019-9f2260ab2455
# ╟─33b73896-710e-11eb-0124-232e6af2e301
# ╠═1ebf9a8e-710c-11eb-3263-23c54d60fad5
# ╠═edab313a-710b-11eb-0f32-09d5d56c4dfa
# ╠═ed74d3e2-710b-11eb-281a-2d137ab134f3
# ╠═ed36db50-710b-11eb-2098-61c05cc88ea2
# ╠═5c9cb590-710d-11eb-0c59-0b40190a84b0
# ╠═4d664d48-710d-11eb-0670-43534108df9d
# ╠═bc0f7f62-710d-11eb-1b99-5dc338cbf054
# ╟─132cff22-710e-11eb-2733-7db2bce67320
# ╠═bba16fae-710d-11eb-3a19-6d0f5c43a13e
# ╠═bb4f43be-710d-11eb-1eb0-1b567145820a
# ╠═eba11678-710d-11eb-0116-eb8cd0c012ac
