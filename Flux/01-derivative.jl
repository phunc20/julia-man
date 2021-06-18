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
  #using BenchmarkTools
end

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

# ╔═╡ e6af47b1-e7e9-4173-afac-24a9141d246d
md"""
## Weird Behaviour of Derivatives at `Irrational`
A good example is worth more than a thousand words.

**Note.** In case you forgot it like me: The natural number `ℯ` is typed by `\euler<Tab>` in Julia.
"""

# ╔═╡ 058d4c3d-9073-42f3-a0d6-4b1569f1a318
derivative(t -> t)(π), derivative(t -> t)(-π), derivative(t -> t)(3.14159)

# ╔═╡ b7e41023-7339-413f-a426-74ae0966eb47
derivative(t -> t)(ℯ), derivative(t -> t)(-ℯ), derivative(t -> t)(2.71828)

# ╔═╡ 32197417-55ea-43c2-adf3-20005b74e25d
typeof(π), typeof(-π), typeof(3.14159)

# ╔═╡ 24e4e0c0-7ea3-4b82-a0f9-2fe2e690bf93
typeof(ℯ), typeof(-ℯ), typeof(2.71828)

# ╔═╡ 8aef747a-22c0-41bd-8174-9c3bb59baa43
md"""
It seems that only the identity function returns `true`.
"""

# ╔═╡ 6718e732-7bec-4ff9-ac33-325b9ae3c585
(t->t)'(π), (t->2t)'(π), (t->t^2)'(π), (t->1)'(0.1)  # For ' and its usage, cf. below

# ╔═╡ 6878b339-114d-4014-aeec-089b08c5564d
(t->1)'(π), nothing

# ╔═╡ d5b0ff5b-caef-4ee4-8f92-26533bdfd30e
(t->t^1.0000000001)'(π)

# ╔═╡ 03f49db3-505a-44a6-b1a1-c00c7cde8cf0
md"""
**(?)** What if we don't use anonymous function?

**(R)** The same.
"""

# ╔═╡ 79a462c7-bfe9-457d-96d2-b66bbcf950fc
let
  function identity(t::Number)
    t
  end
  identity'(π)
end

# ╔═╡ ef96c4f9-4bef-4f61-8512-16fbdd5a6ea3
md"""
## Piecewise Linear Functions
Let's try the `gradient` method on piecewise linear functions.
"""

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

# ╔═╡ c705f239-c6c3-423c-8886-94d67ee52d5a
md"""
The above is to demonstrate the fact that `gradient` will return `nothing` as derivative for functions which are constant. To modify this default behaviour, I have written `derivative` which wrap around `gradient`.
"""

# ╔═╡ a3eeed89-65ee-4654-9460-894e2d789190
md"""
### Problem
I don't know why but for the following hat functions `ϕ`, had we defined them as
```julia
function ϕ(M, j)
  if M <= 0
    error("M must be a positive integer")
  end
  if j < 1 || j > M - 2
    error("j must be a positive integer in [1 .. M-2]")
  end

  function ϕⱼ(t::Number)
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

  return ϕⱼ
end
```

then, when we try to ask Julia about its derivative, say, ask the derivative of `ϕ(M, j)` for ``t \in [t_{j-1}, t_{j+1}]``, Julia will report the following error:

```
Need an adjoint for constructor
StepRangeLen{Float64,Base.TwicePrecision{Float64},Base.TwicePrecision{Float64}}.
Gradient is of type Array{Float64,1}

  1. error(::String)  @  error.jl:33
  2. (::Zygote.Jnew{...
  ...
```

"""

# ╔═╡ 112bf837-5f79-4680-abc8-a007237ec06c
md"""
### Solutions
I find two solutions to this problem. The first one is to keep the original code and only modify the following part:

```julia
tmesh = range(0,1;length=M)
h = tmesh[2]
tⱼ₋₁ = tmesh[j]
tⱼ   = tmesh[j+1]
tⱼ₊₁ = tmesh[j+2]
```

It seems that the `StepRangeLen` thing mentioned in the error message refers to these lines. Replacing these lines with the following code solves the problem and render derivation smooth again.

```julia
function ϕ(M, j)
  if M <= 0
    error("M must be a positive integer")
  end
  if j < 1 || j > M - 2
    error("j must be a positive integer in [1 .. M-2]")
  end

  function ϕⱼ(t::Number)
    h = 1 / (M-1)
    tⱼ₋₁ = (j-1)*h
    tⱼ   = j*h
    tⱼ₊₁ = (j+1)*h

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
  return ϕⱼ
end
```

One may try to run this code along with the following test.
```julia
let
  M = 6
  j = 3
  a = rand((j-2)/(M-1):0.05:(j+2)/(M-1))
  with_terminal() do
    println("M = ", M, ", j = ", j)
    println("ϕ(M, j)(", a, ") = ", ϕ(M,j)(a))
    println("derivative(ϕ(M,j))(", a, ") = ", derivative(ϕ(M,j))(a))
  end
end
```

Another solution I found was as follows:
"""

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
  #@adjoint ϕ(M,j,t) = ϕ(M,j,t), l -> ϕ_adjoint(M,j,t,l)
  @adjoint ϕ(M,j,t) = ϕ(M,j,t), l -> (nothing, nothing, ϕ_adjoint(M,j,t,l))
end

# ╔═╡ d22cf50b-a6c4-48ee-a153-9bef70dbaa18
# let
#   M = 5
#   alpha = 0.7
#   lw = 2
#   ts = range(0,1;length=700)
#   plot(ts,
#        (t->ϕ(M,1,t)).(ts),
#        linealpha=alpha,
#        linewidth=lw,
#        xlim=(0,1.1),
#        xticks=range(0,1;length=M),
#        yticks=range(0,1;length=M),
#        aspect_ratio=:equal,
#        label="ϕ1",
#        legend=:topleft,
#        background_color=:black,
#        title="M = $M",
#   )
#   for j in 2:M-2
#     plot!(ts,
#           (t->ϕ(M,j,t)).(ts),
#           linewidth=lw,
#           linealpha=alpha,
#           label="ϕ$(j)")
#   end
#   plot!()
# end

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
  #a = (j-1)/(M-1)
  a = rand((j-2)/(M-1):0.05:(j+2)/(M-1))
  with_terminal() do
    println("M = ", M, ", j = ", j)
    println("ϕ(M, j, a) = ", ϕ(M,j,a))
    println("derivative(ϕ(M,j,t))(", a, ") = ", derivative(t->ϕ(M,j,t))(a))
  end
end

# ╔═╡ 5575f0e3-9df8-493e-b65b-da2d37e162ff
md"""
The above cell should output (for the derivative)

- `5.0` when `0.4 <= a < 0.6`
- `-5.0` when `0.6 <= a <= 0.8`

These seem to provide a way to differentiate any piecewise linear functions. However, there is sth better yet.
"""

# ╔═╡ 6ef0207c-c71e-4b41-be24-0dbbd43bd0f5
md"""
## A More Elegant Way
This method is thanks to an administrator of the Facebook group `Julia Taiwan` with pseudo `Peter Cheng`. His idea is as follows.

> Piecewise linear functions, like the hat functions above, are **no more special** than `relu`. Why would we ever need to define `@adjoint` for `ϕ` but no need for `relu`? It was `phunc20`'s choice of implementation which led him to the difficulties.

Concretly, the idea was to define one single hat function, and have all the other hat functions be simple variants of the first one (via function composition, for example.)
"""

# ╔═╡ aff04885-9d3c-4c40-a135-38f2f7a5ac4e
function hat(t::Number)
  if t < -1
    return 0
  elseif t > 1
    return 0
  elseif t < 0
    return t + 1
  else
    return 1 - t
  end
end

# ╔═╡ 939e4045-151f-4c23-bf7d-3704b200e996
md"""
### Fun Distraction
Note that we have the following convience way of writing derivatives: $(HTML("<br>"))
(It suffices to `using Flux` or `using Zygote` before using it; otherwise, it will be understood as the adjoint of a matrix.)
"""

# ╔═╡ 7fd8bd8b-751d-4122-8624-599027001025
hat'(0), hat''(0)

# ╔═╡ 7a8aa8e0-b795-4455-87a7-4c21ad9d1528
(x -> x^2)'(2), (x -> x^2)''(2), (x -> x^2)'''(2)

# ╔═╡ 68a44042-1103-423d-a44f-964e9cd1af4e
(t->1)'(10), nothing

# ╔═╡ caf72b7a-90f8-43f3-8079-74fb7333acf0
md"""
As far as I understand, if we use the following `methods(adjoint)`
to find the definition of the method, then it seems to be inside the file
`/home/phunc20/.julia/packages/Zygote/zowrf/src/compiler/interface.jl` (Line 62), which writes

```julia
Base.adjoint(f::Function) = x -> gradient(f, x)[1]
```

So, basically, this is a simple convenience function wrapping around `gradient`.

Because I am kind of lazy and because I have already spent a lot of time editing the present notebook, I shall not take the pain replacing the `gradient` by this, more concise and probably more terminologically correct, prime thing (`'` / `adjoint`).
"""

# ╔═╡ d29fd9aa-4fe7-427b-bdcc-f764d2ee9ec1
#methods(adjoint)

# ╔═╡ dbdfcbbc-a75d-4ce5-94bb-dfdeb946eef3
adjoint(x -> x^2)(2), adjoint(adjoint(x -> x^2))(2)

# ╔═╡ 59a7a886-3b67-4332-bc58-39d6eb862fff
md"""
### Back to Our `hat` Method
"""

# ╔═╡ 3e55cc4a-1859-42c9-9805-004bb0695b0f
derivative(hat).(range(-1.1, 1.1;step=0.3))

# ╔═╡ a89a34e2-18e1-4f12-a54d-abcda44f0be7
gradient(hat, -0.3), gradient(hat, 0), gradient(hat, 1), gradient(hat, 1.1)

# ╔═╡ 58b19198-9515-443a-aec7-6cf2cb0018a2
let
  M = 7
  range(0, 1; length=M)[2] == 1 / (M-1)
end

# ╔═╡ b77d2ca7-3640-48ef-affa-88c3a70290c8
function phi(M::Int, j::Int)
  if M <= 0
    error("M must be a positive integer")
  end
  if j < 1 || j > M - 2
    error("j must be a positive integer in [1 .. M-2]")
  end
  #h = range(0, 1; length=M)[2]
  h = 1 / (M-1)
  tⱼ = j*h
  function intermediate(t::Number)
    return (t - tⱼ) / h
  end
  return hat ∘ intermediate
end

# ╔═╡ 06ec2b9f-2289-4398-acc5-26914f63126d
let
  M = 5
  alpha = 0.7
  lw = 2
  ts = range(0,1;length=700)
  plot(ts,
       phi(M,1).(ts),
       linealpha=alpha,
       linewidth=lw,
       xlim=(0,1.1),
       xticks=range(0,1;length=M),
       yticks=range(0,1;length=M),
       aspect_ratio=:equal,
       label="ϕ1",
       legend=:topleft,
       background_color=:black,
       title="Same plot by hat()",
  )
  for j in 2:M-2
    plot!(ts,
          phi(M,j).(ts),
          linewidth=lw,
          linealpha=alpha,
          label="ϕ$(j)")
  end
  plot!()
end

# ╔═╡ cc4d1ef8-b857-4bad-a914-2876ce4143d7
let
  M = 6
  j = 3

  #a = j/(M-1)
  #a = (j+1)/(M-1)
  #a = (j-0.5)/(M-1)
  #a = (j-1)/(M-1)
  a = rand((j-1)/(M-1):0.05:(j+1)/(M-1))
  with_terminal() do
    println("M = ", M, ", j = ", j)
    println("phi(M, j)(", a, ") = ", phi(M,j)(a))
    println("derivative(phi(M,j))(", a, ") = ", derivative(phi(M,j))(a))
  end
end

# ╔═╡ Cell order:
# ╠═fc5fbca8-cf36-11eb-08e1-7d34e645f9b7
# ╠═f5df8344-8845-4f3e-b0fd-2bb4761c7ca5
# ╠═55fef076-3f49-49a2-b9cf-3bcea969af59
# ╟─e6af47b1-e7e9-4173-afac-24a9141d246d
# ╠═058d4c3d-9073-42f3-a0d6-4b1569f1a318
# ╠═b7e41023-7339-413f-a426-74ae0966eb47
# ╠═32197417-55ea-43c2-adf3-20005b74e25d
# ╠═24e4e0c0-7ea3-4b82-a0f9-2fe2e690bf93
# ╟─8aef747a-22c0-41bd-8174-9c3bb59baa43
# ╠═6718e732-7bec-4ff9-ac33-325b9ae3c585
# ╠═6878b339-114d-4014-aeec-089b08c5564d
# ╠═d5b0ff5b-caef-4ee4-8f92-26533bdfd30e
# ╟─03f49db3-505a-44a6-b1a1-c00c7cde8cf0
# ╠═79a462c7-bfe9-457d-96d2-b66bbcf950fc
# ╟─ef96c4f9-4bef-4f61-8512-16fbdd5a6ea3
# ╠═f4e5f88a-1b35-4dfc-8ecb-274733778c4c
# ╠═73ff8ee2-0bcc-422c-8199-a7462c27fbc1
# ╟─3164f92d-00ef-4949-bb1c-a9521421b257
# ╟─540f5d20-e7d9-41ba-9a69-81b7f81d27ef
# ╟─c705f239-c6c3-423c-8886-94d67ee52d5a
# ╟─a3eeed89-65ee-4654-9460-894e2d789190
# ╟─112bf837-5f79-4680-abc8-a007237ec06c
# ╠═e4bc53a4-83da-48a6-9fe5-2fb0b3c91495
# ╟─d22cf50b-a6c4-48ee-a153-9bef70dbaa18
# ╠═8f8b321d-87a3-4ce4-827e-8c537ebf802a
# ╟─5575f0e3-9df8-493e-b65b-da2d37e162ff
# ╟─6ef0207c-c71e-4b41-be24-0dbbd43bd0f5
# ╠═aff04885-9d3c-4c40-a135-38f2f7a5ac4e
# ╟─939e4045-151f-4c23-bf7d-3704b200e996
# ╠═7fd8bd8b-751d-4122-8624-599027001025
# ╠═7a8aa8e0-b795-4455-87a7-4c21ad9d1528
# ╠═68a44042-1103-423d-a44f-964e9cd1af4e
# ╟─caf72b7a-90f8-43f3-8079-74fb7333acf0
# ╠═d29fd9aa-4fe7-427b-bdcc-f764d2ee9ec1
# ╠═dbdfcbbc-a75d-4ce5-94bb-dfdeb946eef3
# ╟─59a7a886-3b67-4332-bc58-39d6eb862fff
# ╠═3e55cc4a-1859-42c9-9805-004bb0695b0f
# ╠═a89a34e2-18e1-4f12-a54d-abcda44f0be7
# ╠═58b19198-9515-443a-aec7-6cf2cb0018a2
# ╠═b77d2ca7-3640-48ef-affa-88c3a70290c8
# ╠═06ec2b9f-2289-4398-acc5-26914f63126d
# ╠═cc4d1ef8-b857-4bad-a914-2876ce4143d7
