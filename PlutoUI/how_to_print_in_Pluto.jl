### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 94d6decc-8ec7-11eb-3c38-073ede4ab54d
begin
  using Pkg
  Pkg.activate(mktempdir())
  Pkg.add(["PlutoUI"])
  using PlutoUI
end

# ╔═╡ 220e7014-8eca-11eb-3deb-b7a67e3f1603
quote_en = "Chance favors only the prepared mind."

# ╔═╡ 585d397a-8ec7-11eb-32d4-3b7c32112de5
print(quote_en)

# ╔═╡ 95780c34-8ec7-11eb-1bde-b3764ac89fc8
println(quote_en)

# ╔═╡ 01b98b00-8eca-11eb-2a98-d13b1cb00985
quote_fr = "Dans les champs de l'observation le hasard ne favorise que les esprits préparés."

# ╔═╡ e7bb2576-8ec7-11eb-368b-876d26b8f058
print(quote_fr)

# ╔═╡ e6a17a00-8ec7-11eb-2ec3-a9094fedf3fd
println(quote_fr)

# ╔═╡ c73965cc-8ec9-11eb-0b95-0d65a9b784ed
PlutoUI.Print(quote_fr)

# ╔═╡ c717ae0a-8ec9-11eb-1777-f57191ea7959
PlutoUI.Print(quote_en)

# ╔═╡ c6626428-8ec9-11eb-324a-052f6ee4b67b
for _ in 1:10
  PlutoUI.Print(quote_fr)
end

# ╔═╡ 6eb56870-8eca-11eb-29e3-dde30546eb70
with_terminal() do
  for _ in 1:10
    PlutoUI.Print(quote_fr)
  end
end

# ╔═╡ 7dda80ea-8eca-11eb-3fe9-9166bb33fb27
with_terminal() do
  for i in 1:10
    println(quote_fr)
  end
end

# ╔═╡ dfd1158e-8eca-11eb-1e09-2752d1e37cb4
varinfo(PlutoUI)

# ╔═╡ 17ce8d22-8ecb-11eb-17f3-cf986464691d
with_terminal(println, quote_en)

# ╔═╡ 59b8c638-8ecb-11eb-0833-6b23c489bcaf
md"""
cf.
- [https://github.com/fonsp/Pluto.jl/issues/245#issue-670576465](https://github.com/fonsp/Pluto.jl/issues/245#issue-670576465)
"""

# ╔═╡ Cell order:
# ╠═220e7014-8eca-11eb-3deb-b7a67e3f1603
# ╠═585d397a-8ec7-11eb-32d4-3b7c32112de5
# ╠═95780c34-8ec7-11eb-1bde-b3764ac89fc8
# ╠═94d6decc-8ec7-11eb-3c38-073ede4ab54d
# ╠═01b98b00-8eca-11eb-2a98-d13b1cb00985
# ╠═e7bb2576-8ec7-11eb-368b-876d26b8f058
# ╠═e6a17a00-8ec7-11eb-2ec3-a9094fedf3fd
# ╠═c73965cc-8ec9-11eb-0b95-0d65a9b784ed
# ╠═c717ae0a-8ec9-11eb-1777-f57191ea7959
# ╠═c6626428-8ec9-11eb-324a-052f6ee4b67b
# ╠═6eb56870-8eca-11eb-29e3-dde30546eb70
# ╠═7dda80ea-8eca-11eb-3fe9-9166bb33fb27
# ╠═dfd1158e-8eca-11eb-1e09-2752d1e37cb4
# ╠═17ce8d22-8ecb-11eb-17f3-cf986464691d
# ╟─59b8c638-8ecb-11eb-0833-6b23c489bcaf
