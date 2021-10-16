### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 772c3808-2e7f-11ec-001a-3d2fa04c532d
begin
  using Pluto, PlutoUI
  using Yao, YaoPlots
end

# ╔═╡ 5326921d-e3e1-4495-80d9-00f490261523
md"""
## Bell Circuit
"""

# ╔═╡ 7cc2762d-594f-4f32-915d-1ebf2dae2244
begin
  bellcircuit = chain(2, put(1=>H), control(1, 2=>X))
  plot(bellcircuit)
end

# ╔═╡ b031dc71-3565-494a-b6a3-9b85ca4ea235
q0 = ArrayReg(bit"00")

# ╔═╡ 984b5576-4dc7-4a75-a2ea-a3b215376dd4
big"00", bit"01", bit"10", bit"11111111"

# ╔═╡ ebcab48f-d447-441b-b98d-2ffa6a960e0e
state(q0)

# ╔═╡ 547554bc-de0f-4c3a-9552-dc6393062062
md"""
It seems that the `state` method allows to view the qubit in column vector.
"""

# ╔═╡ b223812c-5dfe-4dd6-8130-458a5b3da542
begin
  q1 = ArrayReg(bit"01")
  q2 = ArrayReg(bit"10")
  q3 = ArrayReg(bit"11")
  state(q1), state(q2), state(q3)
end

# ╔═╡ f48440f6-dece-4f83-a16a-18b399dde8e5
#q0 + q2 |> normalize!

# ╔═╡ afb1581d-ae8d-490d-9ab1-c390b96acf03
state(q0)

# ╔═╡ d6527c41-4e47-44ee-8edd-ec3a6e1132b0
#q0 + q2 |> normalize! |> state

# ╔═╡ 90b0d504-6509-4f5b-93cc-a60273b997a6
#q0 + q2 |> state

# ╔═╡ b2e26e4f-f1c0-4d91-885c-12ee91842ca3
# state(q0 + q1)

# ╔═╡ 5ef9f20f-c067-421c-a6c0-38481c595b95
# state(q1 + q2)

# ╔═╡ 9b019df8-d15e-413c-813c-14cdf755a384
zero_state(2) == q0

# ╔═╡ 2e4fcb53-7ef0-48ba-ae17-eb9c3adeef2f
q0 |> bellcircuit |> state

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Pluto = "c3e4b0f8-55cb-11ea-2926-15256bba5781"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Yao = "5872b779-8223-5990-8dd0-5abbb0748c8c"
YaoPlots = "32cfe2d9-419e-45f2-8191-2267705d8dbc"

[compat]
Pluto = "~0.16.1"
PlutoUI = "~0.7.16"
Yao = "~0.6.4"
YaoPlots = "~0.6.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "f87e559f87a45bece9c9ed97458d3afe98b1ebb9"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.1.0"

[[ArrayInterface]]
deps = ["Compat", "IfElse", "LinearAlgebra", "Requires", "SparseArrays", "Static"]
git-tree-sha1 = "b8d49c34c3da35f220e7295659cd0bab8e739fed"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "3.1.33"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BitBasis]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "68ce92be119ad7ff44ebbb9ffc0f7a70b1e34c45"
uuid = "50ba71b6-fa0f-514d-ae9a-0916efc90dcf"
version = "0.7.4"

[[CacheServers]]
deps = ["Distributed", "Test"]
git-tree-sha1 = "b584b04f236d3677b4334fab095796a128445bf8"
uuid = "a921213e-d44a-5460-ac04-5d720a99ba71"
version = "0.2.0"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "2f294fae04aa5069a67964a3366e151e09ea7c09"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.9.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "32a2b8af383f11cbb65803883837a149d10dfe8a"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.10.12"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "31d0151f5716b655421d9d75b7fa74cc4e744df2"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.39.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Compose]]
deps = ["Base64", "Colors", "DataStructures", "Dates", "IterTools", "JSON", "LinearAlgebra", "Measures", "Printf", "Random", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "c6461fc7c35a4bb8d00905df7adafcff1fe3a6bc"
uuid = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
version = "0.9.2"

[[Configurations]]
deps = ["ExproniconLite", "OrderedCollections", "TOML"]
git-tree-sha1 = "79e812c535bb9780ba00f3acba526bde5652eb13"
uuid = "5218b696-f38b-4ac9-8b61-a12ec717816d"
version = "0.16.6"

[[DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Dierckx]]
deps = ["Dierckx_jll"]
git-tree-sha1 = "5fefbe52e9a6e55b8f87cb89352d469bd3a3a090"
uuid = "39dd38d3-220a-591b-8e3c-4c3a8c710a94"
version = "0.5.1"

[[Dierckx_jll]]
deps = ["CompilerSupportLibraries_jll", "Libdl", "Pkg"]
git-tree-sha1 = "a580560f526f6fc6973e8bad2b036514a4e3b013"
uuid = "cd4c43a9-7502-52ba-aa6d-59fb2a88580b"
version = "0.0.1+0"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "a32185f5428d3986f47c2ab78b1f216d5e6cc96f"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.5"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[ExponentialUtilities]]
deps = ["ArrayInterface", "LinearAlgebra", "Printf", "Requires", "SparseArrays"]
git-tree-sha1 = "54b4bd8f88278fd544a566465c943ce4f8da7b7f"
uuid = "d4d017d3-3776-5f7e-afef-a10c40355c18"
version = "1.10.0"

[[Expronicon]]
deps = ["MLStyle", "Pkg", "TOML"]
git-tree-sha1 = "548ff4eb95fa4beef7c59907ad6e249d580e3588"
uuid = "6b7a57c9-7cc1-4fdf-b7f5-e857abae3636"
version = "0.6.12"

[[ExproniconLite]]
git-tree-sha1 = "c04d5c3442126d75ee4500aa6b0e402cae3bf6ac"
uuid = "55351af7-c7e9-48d6-89ff-24e801d99491"
version = "0.6.12"

[[FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[FuzzyCompletions]]
deps = ["REPL"]
git-tree-sha1 = "2cc2791b324e8ed387a91d7226d17be754e9de61"
uuid = "fb4132e2-a121-4a70-b8a1-d5b831dcdcc2"
version = "0.4.3"

[[GraphPlot]]
deps = ["ArnoldiMethod", "ColorTypes", "Colors", "Compose", "DelimitedFiles", "LightGraphs", "LinearAlgebra", "Random", "SparseArrays"]
git-tree-sha1 = "dd8f15128a91b0079dfe3f4a4a1e190e54ac7164"
uuid = "a2cc645c-3eea-5389-862e-a155d0052231"
version = "0.4.4"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "14eece7a3308b4d8be910e265c724a6ba51a9798"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.16"

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

[[IfElse]]
git-tree-sha1 = "28e837ff3e7a6c3cdb252ce49fb412c8eb3caeef"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.0"

[[Inflate]]
git-tree-sha1 = "f5fc07d4e706b84f72d54eedcc1c13d92fb0871c"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.2"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LegibleLambdas]]
deps = ["MacroTools"]
git-tree-sha1 = "7946db4829eb8de47c399f92c19790f9cc0bbd07"
uuid = "f1f30506-32fe-5131-bd72-7c197988f9e5"
version = "0.3.0"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LightGraphs]]
deps = ["ArnoldiMethod", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "432428df5f360964040ed60418dd5601ecd240b6"
uuid = "093fc24a-ae57-5d10-9952-331d41423f4d"
version = "1.3.5"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["ChainRulesCore", "DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "34dc30f868e368f8a17b728a1238f3fcda43931a"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.3"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[LuxurySparse]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "StaticArrays"]
git-tree-sha1 = "f6eb35c3a10571c1d62748250197c66ed4c42607"
uuid = "d05aeea4-b7d4-55ac-b691-9e7fabb07ba2"
version = "0.6.8"

[[MLStyle]]
git-tree-sha1 = "594e189325f66e23a8818e5beb11c43bb0141bcd"
uuid = "d8e11817-5142-5d16-987a-aa16d5891078"
version = "0.4.10"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "5a5bc6bf062f0f95e62d0fe0a2d99699fed82dd9"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.8"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[MsgPack]]
deps = ["Serialization"]
git-tree-sha1 = "a8cbf066b54d793b9a48c5daa5d586cf2b5bd43d"
uuid = "99f44e22-a591-53d1-9472-aa23ef4bd671"
version = "1.1.0"

[[Multigraphs]]
deps = ["LightGraphs", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "2fb7159113eeded54437f8abeab72bb994299bda"
uuid = "7ebac608-6c66-46e6-9856-b5f43e107bac"
version = "0.2.2"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "98f59ff3639b3d9485a03a72f3ab35bab9465720"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.6"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[Pluto]]
deps = ["Base64", "Configurations", "Dates", "Distributed", "FileWatching", "FuzzyCompletions", "HTTP", "InteractiveUtils", "Logging", "Markdown", "MsgPack", "Pkg", "REPL", "Sockets", "TableIOInterface", "Tables", "UUIDs"]
git-tree-sha1 = "d4955d6b5267ed826d03e3f05cc23426492b23c9"
uuid = "c3e4b0f8-55cb-11ea-2926-15256bba5781"
version = "0.16.1"

[[PlutoUI]]
deps = ["Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "4c8a7d080daca18545c56f1cac28710c362478f3"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.16"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Static]]
deps = ["IfElse"]
git-tree-sha1 = "a8f30abc7c64a39d389680b74e749cf33f872a70"
uuid = "aedffcd0-7271-4cad-89d0-dc628f76c6d3"
version = "0.3.3"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3c76dde64d03699e074ac02eb2e8ba8254d428da"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.13"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "65fb73045d0e9aaa39ea9a29a5e7506d9ef6511f"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.11"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableIOInterface]]
git-tree-sha1 = "9a0d3ab8afd14f33a35af7391491ff3104401a35"
uuid = "d1efa939-5518-4425-949f-ab857e148477"
version = "0.1.6"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "fed34d0e71b91734bf0a7e10eb1bb05296ddbcd0"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TupleTools]]
git-tree-sha1 = "3c712976c47707ff893cf6ba4354aa14db1d8938"
uuid = "9d95972d-f1c8-5527-a6e0-b4b365fa01f6"
version = "1.3.0"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Viznet]]
deps = ["Compose", "Dierckx"]
git-tree-sha1 = "7a022ae6ac8b153d47617ed8c196ce60645689f1"
uuid = "52a3aca4-6234-47fd-b74a-806bdf78ede9"
version = "0.3.3"

[[Yao]]
deps = ["BitBasis", "Reexport", "YaoArrayRegister", "YaoBase", "YaoBlocks", "YaoSym"]
git-tree-sha1 = "21e49c3b1f3ec891fd728664feae600c8601b013"
uuid = "5872b779-8223-5990-8dd0-5abbb0748c8c"
version = "0.6.4"

[[YaoAPI]]
git-tree-sha1 = "dc4edfcda2e59fd2624f84941da040a4e30220e3"
uuid = "0843a435-28de-4971-9e8b-a9641b2983a8"
version = "0.1.0"

[[YaoArrayRegister]]
deps = ["Adapt", "BitBasis", "LinearAlgebra", "LuxurySparse", "Random", "StaticArrays", "StatsBase", "TupleTools", "YaoBase"]
git-tree-sha1 = "ae4bbf3795b695cfdd47f07236ad4ea8d8168283"
uuid = "e600142f-9330-5003-8abb-0ebd767abc51"
version = "0.7.9"

[[YaoBase]]
deps = ["BitBasis", "LegibleLambdas", "LinearAlgebra", "LuxurySparse", "MLStyle", "Random", "Reexport", "SparseArrays", "TupleTools", "YaoAPI"]
git-tree-sha1 = "2048ba99289732ee5c2fb279d19a60cca2345ce6"
uuid = "a8f54c17-34bc-5a9d-b050-f522fe3f755f"
version = "0.14.4"

[[YaoBlocks]]
deps = ["BitBasis", "CacheServers", "ExponentialUtilities", "InteractiveUtils", "LegibleLambdas", "LinearAlgebra", "LuxurySparse", "MLStyle", "Random", "SimpleTraits", "SparseArrays", "StaticArrays", "StatsBase", "TupleTools", "YaoArrayRegister", "YaoBase"]
git-tree-sha1 = "dd9fc50384876eb2194bcabc726d96b8995a4ac1"
uuid = "418bc28f-b43b-5e0b-a6e7-61bbc1a2c1df"
version = "0.11.6"

[[YaoHIR]]
deps = ["Expronicon", "MLStyle", "YaoLocations"]
git-tree-sha1 = "938fb1436c702dddbbfb2bf173f28e8ebbc48ee0"
uuid = "6769671a-fce8-4286-b3f7-6099e1b1298a"
version = "0.2.0"

[[YaoLocations]]
git-tree-sha1 = "c90c42c8668c9096deb0c861822f0f8f80cbdc68"
uuid = "66df03fb-d475-48f7-b449-3d9064bf085b"
version = "0.1.6"

[[YaoPlots]]
deps = ["BitBasis", "Colors", "Compose", "GraphPlot", "LightGraphs", "Multigraphs", "Viznet", "YaoBlocks", "ZXCalculus"]
git-tree-sha1 = "4ddc139fadcfb14ca417f794f8172e4aba3e6d3a"
uuid = "32cfe2d9-419e-45f2-8191-2267705d8dbc"
version = "0.6.1"

[[YaoSym]]
deps = ["BitBasis", "LinearAlgebra", "LuxurySparse", "Requires", "SparseArrays", "YaoArrayRegister", "YaoBase", "YaoBlocks"]
git-tree-sha1 = "e34838fa98d02d4c969ba9f92783a12a336e2f88"
uuid = "3b27209a-d3d6-11e9-3c0f-41eb92b2cb9d"
version = "0.4.7"

[[ZXCalculus]]
deps = ["LightGraphs", "LinearAlgebra", "MLStyle", "Multigraphs", "SparseArrays", "YaoHIR", "YaoLocations"]
git-tree-sha1 = "2c8e639422053cbdb7bf515fcb754372c752829b"
uuid = "3525faa3-032d-4235-a8d4-8c2939a218dd"
version = "0.4.4"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═772c3808-2e7f-11ec-001a-3d2fa04c532d
# ╟─5326921d-e3e1-4495-80d9-00f490261523
# ╠═7cc2762d-594f-4f32-915d-1ebf2dae2244
# ╠═b031dc71-3565-494a-b6a3-9b85ca4ea235
# ╠═984b5576-4dc7-4a75-a2ea-a3b215376dd4
# ╠═ebcab48f-d447-441b-b98d-2ffa6a960e0e
# ╟─547554bc-de0f-4c3a-9552-dc6393062062
# ╠═b223812c-5dfe-4dd6-8130-458a5b3da542
# ╠═f48440f6-dece-4f83-a16a-18b399dde8e5
# ╠═afb1581d-ae8d-490d-9ab1-c390b96acf03
# ╠═d6527c41-4e47-44ee-8edd-ec3a6e1132b0
# ╠═90b0d504-6509-4f5b-93cc-a60273b997a6
# ╠═b2e26e4f-f1c0-4d91-885c-12ee91842ca3
# ╠═5ef9f20f-c067-421c-a6c0-38481c595b95
# ╠═9b019df8-d15e-413c-813c-14cdf755a384
# ╠═2e4fcb53-7ef0-48ba-ae17-eb9c3adeef2f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
