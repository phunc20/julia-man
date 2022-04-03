### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 27fa85dd-2456-4427-bfd7-08cc54bc395e
using PlutoUI

# ╔═╡ e6c1986c-33f4-11ec-1946-e5df05a6e0c1
t = @task begin; sleep(5); println("done"); end

# ╔═╡ e7144826-ab18-4990-bad8-5b5a5219cb86
t2 = Task(() -> begin; sleep(5); println("done"); end)

# ╔═╡ 31c77872-67dd-411e-9ae5-ce8ff713cd15
md"""
Executing `schedule(t)` in REPL, you will see `t` waits for `5` seconds and then prints `done`.

In Pluto notebook, I haven't figured out how to have this happen.
"""

# ╔═╡ cb9b6805-87f5-401c-897d-637eaac6a57e
with_terminal() do
  schedule(t)
end

# ╔═╡ 1ff68179-6498-453a-a952-7b9b0e985183
with_terminal() do
  schedule(t2)
end

# ╔═╡ bdef83a7-3a51-4765-964f-affc3c65ed75
md"""
- `schedult(t)`
- `wait(t)`
- `@async x` is equiv. to `schedult(@task x)`

"""

# ╔═╡ a6952e3e-4a1b-4673-96d9-5a2e718912b6
md"""
## `Channel`
- `put!()`
- `take!()`
"""

# ╔═╡ 48070cac-38bc-465d-b307-61c1b7b18408
function producer(c::Channel)
  put!(c, "start")
  for n=1:4
    put!(c, 2n)
  end
  put!(c, "stop")
end

# ╔═╡ af24cd4e-5fde-4f7f-a22c-097386297006
chn1 = Channel(producer)

# ╔═╡ ddf376a6-e56b-40b0-b985-854c61f4416f
take!(chn1)

# ╔═╡ e248ac92-065f-441b-915d-41f20b4b4203
take!(chn1)

# ╔═╡ 65c8d3ed-b839-460b-bfad-6bfb8a727a69
take!(chn1)

# ╔═╡ 9ff4e0cc-7bd5-4e35-9032-c189b685688c
take!(chn1)

# ╔═╡ 322b0fa3-da92-4698-a91c-38a665e620d5
take!(chn1)

# ╔═╡ 3ee92a6c-58a6-4f3a-8d9b-8b7a228642ca
take!(chn1)

# ╔═╡ 3829185c-e473-44bb-a81c-b257ae89b6eb
with_terminal() do
  for x in Channel(producer)
    println(x)
  end
end

# ╔═╡ 2ab86a27-c3e7-4905-a47f-06de908ba414
md"""
**Rmk.**$(HTML("<br>"))
1. `Task` takes a `0`-arg function as input
   ```julia
   # Recall the syntax of Task
   Task(()->x)
   ```
2. `Channel` takes a `1`-arg function as input

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.16"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "f6532909bf3d40b308a0f360b6a0e626c0e263a8"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.1"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "98f59ff3639b3d9485a03a72f3ab35bab9465720"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.6"

[[PlutoUI]]
deps = ["Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "4c8a7d080daca18545c56f1cac28710c362478f3"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.16"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╠═27fa85dd-2456-4427-bfd7-08cc54bc395e
# ╠═e6c1986c-33f4-11ec-1946-e5df05a6e0c1
# ╠═e7144826-ab18-4990-bad8-5b5a5219cb86
# ╟─31c77872-67dd-411e-9ae5-ce8ff713cd15
# ╠═cb9b6805-87f5-401c-897d-637eaac6a57e
# ╠═1ff68179-6498-453a-a952-7b9b0e985183
# ╟─bdef83a7-3a51-4765-964f-affc3c65ed75
# ╟─a6952e3e-4a1b-4673-96d9-5a2e718912b6
# ╠═48070cac-38bc-465d-b307-61c1b7b18408
# ╠═af24cd4e-5fde-4f7f-a22c-097386297006
# ╠═ddf376a6-e56b-40b0-b985-854c61f4416f
# ╠═e248ac92-065f-441b-915d-41f20b4b4203
# ╠═65c8d3ed-b839-460b-bfad-6bfb8a727a69
# ╠═9ff4e0cc-7bd5-4e35-9032-c189b685688c
# ╠═322b0fa3-da92-4698-a91c-38a665e620d5
# ╠═3ee92a6c-58a6-4f3a-8d9b-8b7a228642ca
# ╠═3829185c-e473-44bb-a81c-b257ae89b6eb
# ╟─2ab86a27-c3e7-4905-a47f-06de908ba414
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
