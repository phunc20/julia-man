### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ fc5fbca8-cf36-11eb-08e1-7d34e645f9b7
begin
  using Pkg
  Pkg.activate(Base.Filesystem.homedir() * "/.config/julia/projects/oft")
  using Flux
  using Zygote: @adjoint
  using Plots
  using PlutoUI
  #using TikzPictures
  #using LaTeXStrings
  #using SparseArrays
  #using Profile
  #using BenchmarkTools
end

# ╔═╡ 03702c6a-56d8-45f4-8d7d-e05521915685
md"""
## Piecewise Linear Functions
Let's try the `gradient` method on piecewise linear functions.
"""

# ╔═╡ f5df8344-8845-4f3e-b0fd-2bb4761c7ca5
function derivative(f::Function)::Function
  function f′(t::Number)
    gradient(f, t)[1]
  end
  function g(t)
    if f′(t) === nothing
      0.
    else
      f′(t)
    end
  end
  return g
end

# ╔═╡ 55fef076-3f49-49a2-b9cf-3bcea969af59
function naive_derivative(f::Function)::Function
  return t -> gradient(f, t)[1]
end

# ╔═╡ 37fa0833-abb4-4ab2-af3d-379766f26913
with_terminal() do
  # dump()
  print("phunc20: Hello, world.")
  print("\nI'm phunc20.")
  println("How are you?")
  println("World: I'm fine. And you?")
end

# ╔═╡ f4e5f88a-1b35-4dfc-8ecb-274733778c4c
function relu0(t::Number)
  if t > 0
    t
  else
    0
  end
end

# ╔═╡ 73ff8ee2-0bcc-422c-8199-a7462c27fbc1
function relu1(t::Number)
  if t >= 0
    t
  else
    0
  end
end

# ╔═╡ 3164f92d-00ef-4949-bb1c-a9521421b257
let
  #a = 1/5
  a = 0
  with_terminal() do
    println("relu0(", a, ") = ", relu0(a))
    println("relu0(", -a, ") = ", relu0(-a))
    println("derivative(relu0)(", a, ") = ", derivative(relu0)(a))
    println("naive_derivative(relu0)(", a, ") = ", naive_derivative(relu0)(a))
    println("derivative(relu0)(", -a, ") = ", derivative(relu0)(-a))
    println("naive_derivative(relu0)(", -a, ") = ", naive_derivative(relu0)(-a))
  end
end

# ╔═╡ 540f5d20-e7d9-41ba-9a69-81b7f81d27ef
let
  #a = 1/5
  a = 0
  with_terminal() do
    println("relu1(", a, ") = ", relu1(a))
    println("relu1(", -a, ") = ", relu1(-a))
    println("derivative(relu1)(", a, ") = ", derivative(relu1)(a))
    println("naive_derivative(relu1)(", a, ") = ", naive_derivative(relu1)(a))
    println("derivative(relu1)(", -a, ") = ", derivative(relu1)(-a))
    println("naive_derivative(relu1)(", -a, ") = ", naive_derivative(relu1)(-a))
  end
end

# ╔═╡ 314eb767-61c9-42ad-a28c-6722f4fb9ac1


# ╔═╡ 5fe1ec4f-14cf-4ce1-9e97-08af21fe78ba
# function ϕ(M::Int, j::Int)
#   if M <= 0
#     error("M must be a positive integer")
#   end
#   if j < 1 || j > M - 2
#     error("j must be a positive integer in [1 .. M-2]")
#   end
#   function ϕⱼ(t::Number)
#     tmesh = range(0,1;length=M)
#     h = tmesh[2]
#     tⱼ₋₁ = tmesh[j]
#     tⱼ   = tmesh[j+1]
#     tⱼ₊₁ = tmesh[j+2]

#     if t > tⱼ₊₁
#       return 0
#     elseif t >= tⱼ
#       return (tⱼ₊₁ - t) / h
#     elseif t >= tⱼ₋₁
#       return (t - tⱼ₋₁) / h
#     else
#       return 0
#     end
#   end
#   return ϕⱼ
# end

# ╔═╡ f7fcf011-ac3a-412d-8bac-a77f3731ee46
# begin
#   function ϕ(M::Int, j::Int)
#     if M <= 0
#       error("M must be a positive integer")
#     end
#     if j < 1 || j > M - 2
#       error("j must be a positive integer in [1 .. M-2]")
#     end
#     function ϕⱼ(t::Number)
#       tmesh = range(0,1;length=M)
#       h = tmesh[2]
#       tⱼ₋₁ = tmesh[j]
#       tⱼ   = tmesh[j+1]
#       tⱼ₊₁ = tmesh[j+2]
  
#       if t > tⱼ₊₁
#         return 0
#       elseif t >= tⱼ
#         return (tⱼ₊₁ - t) / h
#       elseif t >= tⱼ₋₁
#         return (t - tⱼ₋₁) / h
#       else
#         return 0
#       end
#     end
#     function ϕⱼ_adjoint(l)
#       tmesh = range(0,1;length=M)
#       h = tmesh[2]
#       tⱼ₋₁ = tmesh[j]
#       tⱼ   = tmesh[j+1]
#       tⱼ₊₁ = tmesh[j+2]
#       if t > tⱼ₊₁
#         return (l*0,)
#       elseif t >= tⱼ
#         return (-l/h,)
#       elseif t >= tⱼ₋₁
#         return (l/h,)
#       else
#         return (l*0,)
#       end
#     end
#     @adjoint ϕⱼ(t) = ϕⱼ(t), ϕⱼ_adjoint
#     return ϕⱼ
#   end
# end

# ╔═╡ 9ad69459-ef86-4e0f-a028-8e76065576d1
# function ϕ(M, j, t)
#   if M <= 0
#     error("M must be a positive integer")
#   end
#   if j < 1 || j > M - 2
#     error("j must be a positive integer in [1 .. M-2]")
#   end
#   tmesh = range(0,1;length=M)
#   h = tmesh[2]
#   tⱼ₋₁ = tmesh[j]
#   tⱼ   = tmesh[j+1]
#   tⱼ₊₁ = tmesh[j+2]

#   if t > tⱼ₊₁
#     return 0
#   elseif t >= tⱼ
#     return (tⱼ₊₁ - t) / h
#   elseif t >= tⱼ₋₁
#     return (t - tⱼ₋₁) / h
#   else
#     return 0
#   end
# end

# ╔═╡ 12bef322-eba3-47e4-b78c-40cac695e316
# function ϕ_adjoint(M, j, l)
#   tmesh = range(0,1;length=M)
#   h = tmesh[2]
#   tⱼ₋₁ = tmesh[j]
#   tⱼ   = tmesh[j+1]
#   tⱼ₊₁ = tmesh[j+2]
#   if t > tⱼ₊₁
#     return (l*0,)
#   elseif t >= tⱼ
#     return (-l/h,)
#   elseif t >= tⱼ₋₁
#     return (l/h,)
#   else
#     return (l*0,)
#   end
# end

# ╔═╡ e4bc53a4-83da-48a6-9fe5-2fb0b3c91495
begin
  #function ϕ(M::Int, j::Int, t::Number)
  function ϕ(M, j, t)
    if M <= 0
      error("M must be a positive integer")
    end
    if j < 1 || j > M - 2
      error("j must be a positive integer in [1 .. M-2]")
    end
    tmesh = range(0,1;length=M)
    h = tmesh[2]
    tⱼ₋₁ = tmesh[j]
    tⱼ   = tmesh[j+1]
    tⱼ₊₁ = tmesh[j+2]
  
    if t > tⱼ₊₁
      return 0
    elseif t >= tⱼ
      return (tⱼ₊₁ - t) / h
    elseif t >= tⱼ₋₁
      return (t - tⱼ₋₁) / h
    else
      return 0
    end
  end
  function ϕ_adjoint(M, j, t, l)
    tmesh = range(0,1;length=M)
    h = tmesh[2]
    tⱼ₋₁ = tmesh[j]
    tⱼ   = tmesh[j+1]
    tⱼ₊₁ = tmesh[j+2]
    if t > tⱼ₊₁
      return (l*0,)
    elseif t >= tⱼ
      return (-l/h,)
    elseif t >= tⱼ₋₁
      return (l/h,)
    else
      return (l*0,)
    end
  end
  @adjoint ϕ(M,j,t) = ϕ(M,j,t), l -> ϕ_adjoint(M,j,t,l)
end

# ╔═╡ d22cf50b-a6c4-48ee-a153-9bef70dbaa18
let
  M = 5
  alpha = 0.7
  lw = 2
  ts = range(0,1;length=700)
  plot(ts,
       #ϕ(M,1).(ts),
       (t->ϕ(M,1,t)).(ts),
       linealpha=alpha,
       linewidth=lw,
       xlim=(0,1.1),
       xticks=range(0,1;length=M),
       yticks=range(0,1;length=M),
       aspect_ratio=:equal,
       label="ϕ1",
       legend=:topleft,
       background_color=:black,
       title="M = $M",
  )
  for j in 2:M-2
    plot!(ts,
          #ϕ(M,j).(ts),
          (t->ϕ(M,j,t)).(ts),
          linewidth=lw,
          linealpha=alpha,
          label="ϕ$(j)")
  end
  plot!()
end

# ╔═╡ 8f8b321d-87a3-4ce4-827e-8c537ebf802a
let
  M = 6
  j = 3
  # Values which work
  #a = 0
  #a = (j-2)/(M-1)
  #a = (j+2)/(M-1)

  # Values which do not work
  #a = j/(M-1)
  #a = (j+1)/(M-1)
  #a = (j-0.5)/(M-1)
  a = (j-1)/(M-1)
  #a = rand((j-1)/(M-1):0.05:j/(M-1))
  with_terminal() do
    println("M = ", M, ", j = ", j)
    #println("ϕ(M, j)(", a, ") = ", ϕ(M,j)(a))
    println("ϕ(M, j)(", a, ") = ", ϕ(M,j,a))
    #println("derivative(ϕ(M,j))(", a, ") = ", derivative(ϕ(M,j))(a))
    println("derivative(ϕ(M,j,t))(", a, ") = ", derivative(t->ϕ(M,j,t))(a))
  end
end

# ╔═╡ aff04885-9d3c-4c40-a135-38f2f7a5ac4e


# ╔═╡ f91dfdb5-cf93-4048-99eb-f5b6d3a5ca46
let
  mul(a, b) = a*b
  @adjoint mul(a, b) = mul(a, b), c̄ -> (c̄*b, c̄*a)
  gradient(mul, 2, 3)
end

# ╔═╡ df80dbe4-d631-4f66-b0b5-158f3ececf9f
let
  mul(a, b) = a*b
  gradient(mul, 2, 3)
end

# ╔═╡ Cell order:
# ╠═fc5fbca8-cf36-11eb-08e1-7d34e645f9b7
# ╟─03702c6a-56d8-45f4-8d7d-e05521915685
# ╠═f5df8344-8845-4f3e-b0fd-2bb4761c7ca5
# ╠═55fef076-3f49-49a2-b9cf-3bcea969af59
# ╟─37fa0833-abb4-4ab2-af3d-379766f26913
# ╠═f4e5f88a-1b35-4dfc-8ecb-274733778c4c
# ╠═73ff8ee2-0bcc-422c-8199-a7462c27fbc1
# ╟─3164f92d-00ef-4949-bb1c-a9521421b257
# ╟─540f5d20-e7d9-41ba-9a69-81b7f81d27ef
# ╠═314eb767-61c9-42ad-a28c-6722f4fb9ac1
# ╟─5fe1ec4f-14cf-4ce1-9e97-08af21fe78ba
# ╟─f7fcf011-ac3a-412d-8bac-a77f3731ee46
# ╟─9ad69459-ef86-4e0f-a028-8e76065576d1
# ╟─12bef322-eba3-47e4-b78c-40cac695e316
# ╠═e4bc53a4-83da-48a6-9fe5-2fb0b3c91495
# ╟─d22cf50b-a6c4-48ee-a153-9bef70dbaa18
# ╠═8f8b321d-87a3-4ce4-827e-8c537ebf802a
# ╠═aff04885-9d3c-4c40-a135-38f2f7a5ac4e
# ╠═f91dfdb5-cf93-4048-99eb-f5b6d3a5ca46
# ╠═df80dbe4-d631-4f66-b0b5-158f3ececf9f
