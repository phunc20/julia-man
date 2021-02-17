### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 1b3e9fd4-711a-11eb-0bc0-efd9eee4f122
using Plots

# ╔═╡ 2de9ff9e-7141-11eb-286a-190b8a6a4021
using PlutoUI

# ╔═╡ 1b3e932c-711a-11eb-39ee-0b3afc237078
#plotly()

# ╔═╡ 1b3e8760-711a-11eb-00cb-b39881d9f386
Plots.PlotlyBackend()

# ╔═╡ 1379b87c-711a-11eb-0536-395733726750
plot(sin, (x->begin
            sin(2x)
        end), 0, 2π, line = 4, leg = false, fill = (0, :orange))

# ╔═╡ b47ca3b2-711a-11eb-0f41-f1027d7b2143
md"""
The `begin ... end` above is not necessary. They are there just to permit the multi-line way to write code.
"""

# ╔═╡ ae5f809e-711a-11eb-0651-efbe262f4ce2
plot(sin, (x -> sin(2x)), 0, 2π, line=4, leg=false, fill=(0, :orange))

# ╔═╡ 41731070-711c-11eb-18fc-03eb99c46f78
md"""
**(?)** `fill=(3, :orange)`? I know `:orange` is for the color, but `0` for what?

"""

# ╔═╡ 3827f3c8-711c-11eb-24ff-57f4894a9a1a
plot(sin, (x -> sin(2x) ), 0, 2π, line=4, leg=false, fill=(3, :orange))

# ╔═╡ 48d419b4-711b-11eb-1501-cd07aa8bc310
md"""
**(?)** `leg`? What does it mean?$(html"<br>")
**(R)** It means **whether or not to display the legend**.
"""

# ╔═╡ 2ffb027c-711b-11eb-334d-b3c7dc48b225
plot(sin, (x -> sin(2x)), 0, 2π, line=4, leg=true, fill=(3, :orange))

# ╔═╡ 5d0ea41c-711b-11eb-0137-b506e373071c
md"""
`line` is the width of pencil with which to draw the border.
"""

# ╔═╡ 52927496-711b-11eb-2fb2-752808df1a36
plot(sin, (x -> sin(2x) ), 0, 2π, line=1, leg=true, fill=(3, :orange))

# ╔═╡ 278a6ff6-713e-11eb-06ac-dd8ce13bbde4
identity(10)

# ╔═╡ ea4dbd18-713e-11eb-3f60-25a3c6df8d52
@bind p Slider(0.1:0.05:10, show_value=true, default=0.5)

# ╔═╡ efd3a002-713e-11eb-2143-a1fbe940c0b2
begin
  plot(identity, (x -> (1 - abs(x)^p)^(1/p)), -1, 1, color=:black, line=3, leg=false, fill=(0, :orange), aspect_ratio=:equal)
  plot!(identity, (x -> -(1 - abs(x)^p)^(1/p)), -1, 1, color=:black, line=3, fill=(0, :orange), aspect_ratio=:equal)
end

# ╔═╡ Cell order:
# ╠═1b3e9fd4-711a-11eb-0bc0-efd9eee4f122
# ╠═1b3e932c-711a-11eb-39ee-0b3afc237078
# ╠═1b3e8760-711a-11eb-00cb-b39881d9f386
# ╠═1379b87c-711a-11eb-0536-395733726750
# ╟─b47ca3b2-711a-11eb-0f41-f1027d7b2143
# ╠═ae5f809e-711a-11eb-0651-efbe262f4ce2
# ╠═41731070-711c-11eb-18fc-03eb99c46f78
# ╠═3827f3c8-711c-11eb-24ff-57f4894a9a1a
# ╟─48d419b4-711b-11eb-1501-cd07aa8bc310
# ╠═2ffb027c-711b-11eb-334d-b3c7dc48b225
# ╟─5d0ea41c-711b-11eb-0137-b506e373071c
# ╠═52927496-711b-11eb-2fb2-752808df1a36
# ╠═278a6ff6-713e-11eb-06ac-dd8ce13bbde4
# ╠═2de9ff9e-7141-11eb-286a-190b8a6a4021
# ╠═ea4dbd18-713e-11eb-3f60-25a3c6df8d52
# ╠═efd3a002-713e-11eb-2143-a1fbe940c0b2
