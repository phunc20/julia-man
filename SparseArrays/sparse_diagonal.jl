### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 57c002c6-ca03-11eb-226e-a9a6aa4a20eb
begin
  using Pkg
  Pkg.activate(Base.Filesystem.homedir() * "/.config/julia/projects/oft")
  using Plots
  using PlutoUI
  using SparseArrays
end

# ╔═╡ 2600e777-ca32-422b-b497-d5d10e2fb072
md"""
## Sparse Diagonal Matrices
- multiple diagonal
- single, main diagonal
- Not restrict to square matrices

First we show how to construct **multiple diagonal** sparse matrices.
"""

# ╔═╡ 7bf065dd-734a-425d-a496-29bfc74d061d
spdiagm(-1 => [1,2,3,4], 2 => [3,2,1])

# ╔═╡ 6219ab04-6d0d-4018-ac87-d9312d08f30a
md"""
**(?)** Hmmm... how to print it as a dense matrix?
"""

# ╔═╡ ea4d82d6-e9c3-4d97-ade4-160d6e5608af
with_terminal() do
  print(spdiagm(-1 => [1,2,3,4], 2 => [3,2,1]))
end

# ╔═╡ b9decda3-8236-4005-b825-c8d2eda7bf47
Array(spdiagm(-1 => [1,2,3,4], 2 => [3,2,1]))

# ╔═╡ d80dd906-0208-452a-9eff-95f79a03b711
[2 for _ = 1:5]

# ╔═╡ bde7d0b6-6d5f-4204-a293-1bc9c1f0be93
ones(5) * 2

# ╔═╡ e1a320e6-0a53-4262-a7d6-1d89f04bf998
Array(spdiagm(-1 => [1,2,3,4], 1 => [4,3,2,1], 0 => [2 for _ = 1:5]))

# ╔═╡ 5f7a212b-4f30-4255-8352-0eee93069598
Array(spdiagm(0 => [1,-1]))

# ╔═╡ 15e4597c-28a4-4c5a-8660-16bcbdaa4be3
md"""
For construction of **single, main diagonal** matrices, there is another dispatch of `spdiagm`:
"""

# ╔═╡ 33e188ea-9699-448a-9d5f-d6dc2ec2eded
## Only available from Julia 1.6
#spdiagm([0,1,2,3,4,5])

# ╔═╡ 80f8c38a-8634-422a-ab86-3f6b852b21dd
md"""
Note that the output is not restricted to square matrices -- We can specify the size of the matrix.
"""

# ╔═╡ d7b9e049-7fc2-479a-86b7-0864d4c403cb
## This is wrong: Shouldn't use m=, n=; instead, just specify an integer literal
#Array(spdiagm(m=10, n=5, -1 => [1,2,3,4], 1 => [4,3,2,1], 0 => [2 for _ = 1:5]))

# ╔═╡ f5c2f6a9-d6a0-4774-8da8-5cba96392441
Array(spdiagm(10, 5, -1 => [1,2,3,4], 1 => [4,3,2,1], 0 => [2 for _ = 1:5]))

# ╔═╡ da2bdb8a-2764-41a3-8d91-37d6115a483c
Array(spdiagm(5, 10, -1 => [1,2,3,4], 1 => [4,3,2,1], 0 => [2 for _ = 1:5]))

# ╔═╡ 08d6d8cb-8e71-40d8-9c5d-d60e21c0f52f
Array(spdiagm(10, 10, -1 => [1,2,3,4], 1 => [4,3,2,1], 0 => [2 for _ = 1:5]))

# ╔═╡ 8272f7a2-8219-4bfd-a37e-e60aaea4b633
Array(spdiagm(5, 3, -1 => [1,2,3,4], 1 => [4,3,2,1], 0 => [2 for _ = 1:5]))

# ╔═╡ Cell order:
# ╠═57c002c6-ca03-11eb-226e-a9a6aa4a20eb
# ╟─2600e777-ca32-422b-b497-d5d10e2fb072
# ╠═7bf065dd-734a-425d-a496-29bfc74d061d
# ╟─6219ab04-6d0d-4018-ac87-d9312d08f30a
# ╠═ea4d82d6-e9c3-4d97-ade4-160d6e5608af
# ╠═b9decda3-8236-4005-b825-c8d2eda7bf47
# ╠═d80dd906-0208-452a-9eff-95f79a03b711
# ╠═bde7d0b6-6d5f-4204-a293-1bc9c1f0be93
# ╠═e1a320e6-0a53-4262-a7d6-1d89f04bf998
# ╠═5f7a212b-4f30-4255-8352-0eee93069598
# ╟─15e4597c-28a4-4c5a-8660-16bcbdaa4be3
# ╠═33e188ea-9699-448a-9d5f-d6dc2ec2eded
# ╟─80f8c38a-8634-422a-ab86-3f6b852b21dd
# ╠═d7b9e049-7fc2-479a-86b7-0864d4c403cb
# ╠═f5c2f6a9-d6a0-4774-8da8-5cba96392441
# ╠═da2bdb8a-2764-41a3-8d91-37d6115a483c
# ╠═08d6d8cb-8e71-40d8-9c5d-d60e21c0f52f
# ╠═8272f7a2-8219-4bfd-a37e-e60aaea4b633
