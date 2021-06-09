### A Pluto.jl notebook ###
# v0.14.7

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

# ╔═╡ 5efdba08-c925-11eb-2ba2-838ab13b9021
begin
  using Pkg
  Pkg.activate(Base.Filesystem.homedir() * "/.config/julia/projects/oft")
  using Plots
  using PlutoUI
  using DifferentialEquations
end

# ╔═╡ c4e0849a-c838-4e43-9b3d-99e22510c708
using LaTeXStrings

# ╔═╡ 973b6e86-5286-45fd-81ee-0933fdf88b4d
begin
  md"""
  α $(@bind α Slider(-10:0.01:10, show_value=true, default=1.01))
  $(HTML("<br>"))
  u0 $(@bind u0 Slider(0:0.1:3, show_value=true, default=0.5))
  """
end

# ╔═╡ d7668285-e558-4f1f-8871-1f02b9bc7202
f(u, p, t) = α*u

# ╔═╡ 0d342cfd-88fe-4853-aedd-1f422cc89ae1
tspan = (0.0, 1.0)

# ╔═╡ fe94d6d7-6d97-4705-86cf-88ee13958e06
prob = ODEProblem(f, u0, tspan)

# ╔═╡ 8b75c62a-9cba-4e8a-8bfd-00a370a541bd
sol = solve(prob)

# ╔═╡ e13eff41-adce-4249-8f67-a850f2c4def0
sol[5]

# ╔═╡ 99dbec68-bf46-4b3a-a56f-96104700d691
sol.t

# ╔═╡ ded65bae-3e7a-4d9f-ac64-db39a1d2bb13
[t+u for (u,t) in tuples(sol)]

# ╔═╡ 16f0bec3-ab94-4c21-b7bf-4c0801c4be86
tuple(sol)

# ╔═╡ 68be5f1e-e86b-42cf-b835-7d6945941af1
typeof(tuple(sol)), length(tuple(sol))

# ╔═╡ 960a9f1e-efd4-403b-b974-dd5d03d9a641
md"""
If you look closer, it's `tuples` instead of `tuple`!
"""

# ╔═╡ e8e0187b-852b-4213-bf8c-b7f0ee8e69ef
tuples(sol)

# ╔═╡ 0ed98158-1391-491b-99f4-967c6bb2ffde
typeof(tuples(sol)), length(tuples(sol))

# ╔═╡ e245ea21-c517-44f6-9673-1b302f0ee07d
[t+2u for (u,t) in zip(sol.u,sol.t)]

# ╔═╡ 30b36ce3-ad65-4759-a185-598730fd8224
sol.u

# ╔═╡ 86b5cf9d-c1eb-4b90-87f3-7d803c9e73fd
md"""
**(?)** Does the function `u` have to be always named `u`?
"""

# ╔═╡ aaf053ff-b49d-4bd7-8b61-be069f374adc
md"""
The solution `sol` can readily interpolate any `t` value for us.
"""

# ╔═╡ c98843a0-72de-4a7f-9b5b-da53d1b4eb20
[sol.t sol.u]

# ╔═╡ daac7987-ac3a-424a-9c72-175f859cd3dd
sol(0.343), sol(0.666)  # The values of the solution at t = 0.343 and at t = 0.666

# ╔═╡ 1efb7cee-1ba3-4cf5-8307-59d769973687
md"""
## Plotting The Solution
Others have nicely implemented a method `plot` which expects an input like our `sol`:
"""

# ╔═╡ cadf2d1a-1d4f-401b-91df-c06a14521057
#plotly()
plot(sol)

# ╔═╡ dc83ca6c-6eab-4f4d-bca1-4f64728d4b2d
begin
  gui()  # no effect in Pluto :(
  plot(sol,
       linewidth=5,
       title=L"\textrm{Solution to } \frac{du}{dt} = \alpha u",
       xaxis=L"t",
       yaxis=L"u",
       label="Our Solution",
  )
  plot!(sol.t,
        t->u0*exp(α*t),
        lw=3,      # lw for "line width"
        ls=:dash,  # ls for "line style"
        label="True Solution",
  )
end

# ╔═╡ 2c19f9bd-99fa-4dd1-8f0c-e212911cd4da


# ╔═╡ 2a171846-05ab-45f3-82c5-9db992acaec6


# ╔═╡ Cell order:
# ╠═5efdba08-c925-11eb-2ba2-838ab13b9021
# ╟─973b6e86-5286-45fd-81ee-0933fdf88b4d
# ╠═d7668285-e558-4f1f-8871-1f02b9bc7202
# ╠═0d342cfd-88fe-4853-aedd-1f422cc89ae1
# ╠═fe94d6d7-6d97-4705-86cf-88ee13958e06
# ╠═8b75c62a-9cba-4e8a-8bfd-00a370a541bd
# ╠═e13eff41-adce-4249-8f67-a850f2c4def0
# ╠═99dbec68-bf46-4b3a-a56f-96104700d691
# ╠═ded65bae-3e7a-4d9f-ac64-db39a1d2bb13
# ╠═16f0bec3-ab94-4c21-b7bf-4c0801c4be86
# ╠═68be5f1e-e86b-42cf-b835-7d6945941af1
# ╟─960a9f1e-efd4-403b-b974-dd5d03d9a641
# ╠═e8e0187b-852b-4213-bf8c-b7f0ee8e69ef
# ╠═0ed98158-1391-491b-99f4-967c6bb2ffde
# ╠═e245ea21-c517-44f6-9673-1b302f0ee07d
# ╠═30b36ce3-ad65-4759-a185-598730fd8224
# ╟─86b5cf9d-c1eb-4b90-87f3-7d803c9e73fd
# ╟─aaf053ff-b49d-4bd7-8b61-be069f374adc
# ╠═c98843a0-72de-4a7f-9b5b-da53d1b4eb20
# ╠═daac7987-ac3a-424a-9c72-175f859cd3dd
# ╟─1efb7cee-1ba3-4cf5-8307-59d769973687
# ╠═cadf2d1a-1d4f-401b-91df-c06a14521057
# ╠═c4e0849a-c838-4e43-9b3d-99e22510c708
# ╠═dc83ca6c-6eab-4f4d-bca1-4f64728d4b2d
# ╠═2c19f9bd-99fa-4dd1-8f0c-e212911cd4da
# ╠═2a171846-05ab-45f3-82c5-9db992acaec6
