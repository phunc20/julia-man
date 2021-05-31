### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ c734673a-c6e6-4de3-b8d4-fa68b870c255
begin
  import Pkg
  Pkg.activate("/home/phunc20/.config/julia/projects/oft")
  using Flux
end

# ╔═╡ d10152c2-824e-11eb-13f6-6baeb4aec189
begin
  using Random
  Random.seed!(42)
end

# ╔═╡ 8d070ed4-8197-11eb-1ca9-f5354be2ffbd
#begin
#  import Pkg
#  Pkg.activate(mktempdir())
#  Pkg.add([
#    "Flux"
#  ])
#  using Flux
#end

# ╔═╡ b6aa07da-52bb-43d9-a0e6-f2acb7555b75
Pkg.status()

# ╔═╡ d2130040-81b8-11eb-1475-0b09814b3f1b
md"## Taking Gradients"

# ╔═╡ 814b60ca-8199-11eb-36f6-8f46f90b8b4f
f(x) = 3x^2 + 2x + 1

# ╔═╡ b32bb1e4-8199-11eb-3a2b-5b84551b25fc
#∇f(x) = gradient(f, x)[1]
f′(x) = gradient(f, x)[1]

# ╔═╡ 92b0854f-f388-4c87-84db-8994c88d687e
md"""
**Note.** To type `f′`
- do `f\prime<Tab>`
- don't do `f\^'<Tab>`, `f\'<Tab>`, or anything aussi stupide
"""

# ╔═╡ c634e58f-3fe4-4969-a235-48a468f00b72
#∇f(2)
f′(2)

# ╔═╡ 94c39f1d-2403-4108-a110-2f11407cd3b8
methods(f′)

# ╔═╡ cab491ce-81af-11eb-104e-235b93a73465
md"""
If we inspect `typeof(gradient(f, x))`, then we'll get the following error message:
```
UndefVarError: x not defined
```
As you might already come to think, the expression **`∇f(x) = gradient(f, x)[1]`** defines a function (of `x`)
and that's why our inspection is being complained about not having specified `x`.
"""

# ╔═╡ 18e710bb-1391-4756-9a9a-c017d88762b0
#typeof(gradient(f, x))

# ╔═╡ 38581a5a-0f35-4428-b8ce-32fd455078df
typeof(f′)

# ╔═╡ 3bc381a6-f9e7-4da1-a6e7-e85bced2bc0a
md"""
**(?)** The `[1]` in `f′(x) = gradient(f, x)[1]`, what for?

**(R)** I guess, `gradient` is an implementation of **autodiff** / **dual number**. Let's try to define `g(x) = gradient(f, x)[2]`.
"""

# ╔═╡ 061d9944-81b3-11eb-1168-956e97f2c08c
md"""
##### Explore why `[1]` was used in `f′(x) = gradient(f, x)[1]`
"""

# ╔═╡ f0ade939-c585-4444-a7c2-57e867ac89c4
g(x) = gradient(f, x)[2]

# ╔═╡ e68afab8-81b2-11eb-181e-57ca41e0499a
unknown_fn(x) = gradient(f,x)

# ╔═╡ f1e9fc74-81b2-11eb-24e5-a1b108bd1447
unknown_fn(2)

# ╔═╡ 26de32e3-9ef9-44ee-a9c3-06a7269b2428
typeof(unknown_fn)

# ╔═╡ fd2a6966-81b2-11eb-1dd2-b76db5f23d58
typeof(unknown_fn(2))

# ╔═╡ 55e38b1b-de31-4854-8f93-517cd2afb7f1
gg(x) = x^2

# ╔═╡ d1916610-9725-4a10-9236-2faf2fad85e9
(gg,)[1](2)

# ╔═╡ 1679cd48-4c93-4880-8a8e-d4d01b63b675
(gg,)(2)

# ╔═╡ 20a73a86-81b3-11eb-3e16-8d5e4515bb79
md"Let's differentiate once more."

# ╔═╡ b8fe595a-81b2-11eb-2b8c-63f6a9dfb2e9
#∇²f(x) = gradient(∇f, x)[1]
f′′(x) = gradient(f′, x)[1]

# ╔═╡ b8db14b0-81b2-11eb-2c54-4966a6093c71
#∇²f(3.14159)
f′′(3.14159)

# ╔═╡ 7fa826d0-81b3-11eb-3184-09d566e31674
md"""
It is not mandatory to use `gradient()` through defining a function like we did before. Instead, we can use `gradient()` with constant input args as well.
"""

# ╔═╡ 75eaf939-2872-4f65-be93-87f53153b739
gradient(f, 10)  # 6x + 2 when x = 10

# ╔═╡ b8b1cd2e-81b2-11eb-32b4-bd8c62b6133a
g(x, y) = sum((x .- y).^2)

# ╔═╡ 9f638357-9795-4690-acfb-71a3d703eb2d
g(2)

# ╔═╡ b85ced88-81b2-11eb-18be-4da0e21d7c6a
gradient(g, [2,1], [2,0])

# ╔═╡ c8ec8320-81b3-11eb-3886-8535bfbc54b2
md"""
Let's verify if this is correct:$(HTML("<br>"))

$g(x,y) = g(x_1, \ldots, x_n, y_1, \ldots, y_n) := \sum_{i=1}^{n} (x_i - y_i)^2 = || x - y ||^{2}\,.$

The gradient equals

$\nabla g(x,y) = \begin{bmatrix}
  2(x_1 - y_1) \\
  \vdots \\
  2(x_n - y_n) \\
  2(y_1 - x_1) \\
  \vdots \\
  2(y_n - x_n) \\
\end{bmatrix}\,.$

Consequently,

$\nabla g(\begin{bmatrix}2\\1\end{bmatrix}, \begin{bmatrix}2\\0\end{bmatrix}) = \begin{bmatrix}
  2(2 - 2) \\
  2(1 - 0) \\
  2(2 - 2) \\
  2(0 - 1)
\end{bmatrix} = \begin{bmatrix}
  0 \\
  2 \\
  0 \\
  -2
\end{bmatrix}
\,.$

"""

# ╔═╡ b8190986-81b2-11eb-2605-f79e1cc310dc
md"""
There exists **a third way of writing gradient** which could come in handy when we have a lot of independent variables
and that we need to evaluate the gradient at some point:
"""

# ╔═╡ ce7809f4-81ba-11eb-1d04-231c2fb609a9
begin
  x = [i for i in 1:25]
  y = [i^2 for i in 1:25]
  x, y
end

# ╔═╡ c9142f50-81b9-11eb-04b8-afafe176c23f
∇g = gradient(params(x,y)) do
  g(x,y)
end

# ╔═╡ b7e4e306-81ba-11eb-2884-cbe7102a9fb1
∇g[x]

# ╔═╡ d8f58d02-81ba-11eb-026b-ed82844e7051
∇g[y]

# ╔═╡ ef711a12-819d-11eb-074d-897cd7b3f324
md"""
`∇g[[1,2,3]]` gives
```
KeyError: key [1, 2, 3] not found
```
"""

# ╔═╡ 45d3a52f-0486-4cfd-8722-bd0f09364423
#∇g[[1,2,3]]

# ╔═╡ 2262e6d8-81bb-11eb-3970-ddee38c19cc4
md"""
## A Simple Linear Regression Model
"""

# ╔═╡ d1008464-824e-11eb-08d2-bb62d6629dc3
W = rand(2, 5)

# ╔═╡ d0ffcf60-824e-11eb-2608-f57deece6f4a
b = rand(2)

# ╔═╡ cfbd8408-824e-11eb-1dc8-1b6d1d223b96
predict(x) = W*x .+ b  # x should be in R⁵

# ╔═╡ 6c77eb26-824f-11eb-0d19-e164e5f38851
function loss(x, y)
  ŷ = predict(x)
  sum((y .- ŷ).^2)
end

# ╔═╡ 6c397e2c-824f-11eb-2866-79a94e1bce3a
md"""
**Note**. `ŷ` can be obtained by typing `y\hat<Tab>`.$(HTML("<br>"))
Not the other way around: `\hat<Tab>y` gives ` ̂y`, which is not recognizable in Julia/Pluto.

The same logic applies to `bar` as well: `W̄` is
- constructed by the combination `W\bar<Tab>`
- not by `\bar<Tab>W`
"""

# ╔═╡ 6bc0b0e6-824f-11eb-1330-31c0422a6f1c
x₀, y₀ = rand(5), rand(2)  # data

# ╔═╡ 6b36ebfe-824f-11eb-3f16-ffd4687d05b6
loss(x₀, y₀)

# ╔═╡ a4bfbb96-824f-11eb-0f40-9daf904940c4
∇loss = gradient(() -> loss(x₀, y₀), params(W, b))

# ╔═╡ e0c2fff8-a3ca-4b7f-bf4b-4cce0aaed63e
md"""
I think that the cell above is equiv. to the following:

```julia
∇loss = gradient(params(W, b)) do
  loss(x₀, y₀)
end
```
"""

# ╔═╡ 11c67d38-761f-407a-a897-a962a171d1a5
#∇loss = gradient(params(W, b)) do
#  loss(x₀, y₀)
#end

# ╔═╡ f3e6f3c2-824f-11eb-204b-6997de39bb92
begin
  W .-= 0.1 .* ∇loss[W]
  b .-= 0.1 .* ∇loss[b]
end

# ╔═╡ a43348f0-824f-11eb-2384-db33794105c6
loss(x₀, y₀)  # with the updated W and b, loss indeed decreases

# ╔═╡ b2c5e90a-8251-11eb-141d-b309e053bd5e
md"""
## Building Layers
"""

# ╔═╡ 6fa6f0da-8252-11eb-190b-836cd888b111
md"""
There exist multiple ways to build Neural Network Layers. We shall introduce a few of them, with increasing level of manual work.

### Manually1
"""

# ╔═╡ b2a7dc28-8251-11eb-2523-21048c2ca80b
begin
  W1 = rand(3,5)
  b1 = rand(3)
  layer1(x) = W1*x .+ b1
end

# ╔═╡ b28be59a-8251-11eb-3a91-3996e3d04040
begin
  W2 = rand(2,3)
  b2 = rand(2)
  layer2(x) = W2*x .+ b2
end

# ╔═╡ b26c495e-8251-11eb-1d36-a31212b92f01
begin
  model_manual1(x) = layer2(σ.(layer1(x)))
  model_manual1(rand(5))
end

# ╔═╡ b24a0dda-8251-11eb-1904-23fcfbed48fe
md"""
### Manually2: Template
"""

# ╔═╡ b229ae00-8251-11eb-35c0-a3709955aa50
function linear(n_in, n_out)
  W = randn(n_out, n_in)  # we could have used rand() instead of randn(), too.
  b = randn(n_out)
  x -> W*x .+ b
end

# ╔═╡ c95f8c89-200f-4dd3-8d0f-21e2df9f455e
md"""
**N.B.** The function `linear`'s return value is **another function**, namely the function `x -> W*x .+ b`
"""

# ╔═╡ 0435d5ba-8253-11eb-1b84-a7c2f752aa4c
begin
  linear1 = linear(5, 3)  # we can access linear1.W, etc.
  linear2 = linear(3, 2)
end

# ╔═╡ 04246974-8253-11eb-1415-cfd21ba19213
linear1.W

# ╔═╡ 03f7e1b0-8253-11eb-1acf-4fbfa23b2d98
linear2.b

# ╔═╡ 03aefc98-8253-11eb-1b8a-c3a3d9d642bf
md"""
This is a rather special feature of Julia: _Functions can have attributes_.
"""

# ╔═╡ b1d52470-8251-11eb-231c-b3287d3af027
model_manual2(x) = linear2(σ.(linear1(x)))

# ╔═╡ b161cf5e-8251-11eb-2885-99e9b56e6d9f
model_manual2(rand(5))

# ╔═╡ 049d3084-8253-11eb-0324-b5f563aff8f3
md"""
### Manually3: Template
"""

# ╔═╡ e81a6060-8254-11eb-3608-25569cd3a40f
md"""
**Note.** In Pluto, the two definitions above **_must be grouped into a single cell_**; otherwise, Pluto will
complain about multiple definitions of the same object/data structure.
"""

# ╔═╡ b565c036-8254-11eb-2472-758e00842f4b
a = Affine(10,5)

# ╔═╡ 046fb640-8253-11eb-18fa-b34bef08ad65
a(rand(10))

# ╔═╡ 5ed138fe-8256-11eb-39f1-371d2390dc3b
md"""
`Flux` provides a `Dense` object which does more or less the same thing as above. `Dense` can be specified
- w/ an activation function
- w/o an activatoin function
Just as the following two cells show.
"""

# ╔═╡ 49799d40-8256-11eb-2f49-4d3e6ca8e337
Dense(10, 5, σ)(rand(10))

# ╔═╡ 0921c9a9-b452-48f4-8d31-999384d1957f
#Dense(10, 5, softmax)(rand(10))  # Unlike σ, softmax is not scalar-arg

# ╔═╡ 492a1200-8256-11eb-25ea-2fd41050493f
Dense(10, 5)(rand(10))

# ╔═╡ a03ee0f6-8261-11eb-3fda-c1e1c7e294dd
md"""
## Using `Dense`, `Chain` and Other `Flux` Stuffs
We could have done the same as above using
```julia
layer1 = Dense(10, 5, σ)
# ...
model(x) = layer3(layer2(layer1(x)))
```
There can be still other ways:
"""

# ╔═╡ a02b04dc-8261-11eb-28a4-5975841e3647
layers = [Dense(10, 5, σ), Dense(5,2), softmax]

# ╔═╡ de8f97de-8262-11eb-371f-67987e1b8d6e
md"""
Oh, BTW, as you might have already noticed
- `σ`
- `softmax`
are all defined in `Flux`
"""

# ╔═╡ c442a2c0-8262-11eb-313f-a3e2936b7aa5
model_fold(x) = foldl((x,m) -> m(x), layers, init=x)

# ╔═╡ a00c721a-8261-11eb-1bec-1f438963b38a
md"""
The concept and usage of `foldl` seems to resemble that of its equivalent in Scala.
"""

# ╔═╡ f8bfc65e-8262-11eb-1d53-6d11a6bd70cf
begin
  res = model_fold(rand(10))
  res, sum(res)
end

# ╔═╡ f8844dfe-8262-11eb-1dab-65376333ce1e
# MNIST-like input/output
model2 = Chain(
  Dense(27*27, 100, σ),
  Dense(100, 10),
  softmax,
)

# ╔═╡ f85ff918-8262-11eb-26e3-fb87245d3238
model2(rand(27*27))

# ╔═╡ 807b8d9c-8265-11eb-21bd-83508a1ae74c
md"""
There exists still many other ways of composing/writing things up:
"""

# ╔═╡ a27fda58-8265-11eb-3237-3996e53f82c1
(Dense(5,2) ∘ Dense(10, 5, σ))(rand(10))

# ╔═╡ a2420af0-8265-11eb-1372-6b767e5c2a64
Chain(x -> x^2, x -> x+1, t -> 2*t)(5)

# ╔═╡ 666f0b08-8266-11eb-201d-4354eb9cae08
md"""
## `outdims()` function
"""

# ╔═╡ b59da87c-8254-11eb-0823-3f1bedd509e0
# Overload call, so an instance of the object can be used as a function
(m::Affine)(x) = m.W * x .+ m.b

# ╔═╡ 049570d0-8253-11eb-2d1d-35cacf8c0597
begin
  struct Affine
    W
    b
  end
  
  Affine(n_in::Integer, n_out::Integer) = Affine(randn(n_out, n_in), randn(n_out))
end

# ╔═╡ Cell order:
# ╠═8d070ed4-8197-11eb-1ca9-f5354be2ffbd
# ╠═c734673a-c6e6-4de3-b8d4-fa68b870c255
# ╠═b6aa07da-52bb-43d9-a0e6-f2acb7555b75
# ╟─d2130040-81b8-11eb-1475-0b09814b3f1b
# ╠═814b60ca-8199-11eb-36f6-8f46f90b8b4f
# ╠═b32bb1e4-8199-11eb-3a2b-5b84551b25fc
# ╟─92b0854f-f388-4c87-84db-8994c88d687e
# ╠═c634e58f-3fe4-4969-a235-48a468f00b72
# ╠═94c39f1d-2403-4108-a110-2f11407cd3b8
# ╟─cab491ce-81af-11eb-104e-235b93a73465
# ╠═18e710bb-1391-4756-9a9a-c017d88762b0
# ╠═38581a5a-0f35-4428-b8ce-32fd455078df
# ╟─3bc381a6-f9e7-4da1-a6e7-e85bced2bc0a
# ╟─061d9944-81b3-11eb-1168-956e97f2c08c
# ╠═f0ade939-c585-4444-a7c2-57e867ac89c4
# ╠═9f638357-9795-4690-acfb-71a3d703eb2d
# ╠═e68afab8-81b2-11eb-181e-57ca41e0499a
# ╠═f1e9fc74-81b2-11eb-24e5-a1b108bd1447
# ╠═26de32e3-9ef9-44ee-a9c3-06a7269b2428
# ╠═fd2a6966-81b2-11eb-1dd2-b76db5f23d58
# ╠═55e38b1b-de31-4854-8f93-517cd2afb7f1
# ╠═d1916610-9725-4a10-9236-2faf2fad85e9
# ╠═1679cd48-4c93-4880-8a8e-d4d01b63b675
# ╟─20a73a86-81b3-11eb-3e16-8d5e4515bb79
# ╠═b8fe595a-81b2-11eb-2b8c-63f6a9dfb2e9
# ╠═b8db14b0-81b2-11eb-2c54-4966a6093c71
# ╟─7fa826d0-81b3-11eb-3184-09d566e31674
# ╠═75eaf939-2872-4f65-be93-87f53153b739
# ╠═b8b1cd2e-81b2-11eb-32b4-bd8c62b6133a
# ╠═b85ced88-81b2-11eb-18be-4da0e21d7c6a
# ╟─c8ec8320-81b3-11eb-3886-8535bfbc54b2
# ╟─b8190986-81b2-11eb-2605-f79e1cc310dc
# ╠═ce7809f4-81ba-11eb-1d04-231c2fb609a9
# ╠═c9142f50-81b9-11eb-04b8-afafe176c23f
# ╠═b7e4e306-81ba-11eb-2884-cbe7102a9fb1
# ╠═d8f58d02-81ba-11eb-026b-ed82844e7051
# ╟─ef711a12-819d-11eb-074d-897cd7b3f324
# ╠═45d3a52f-0486-4cfd-8722-bd0f09364423
# ╟─2262e6d8-81bb-11eb-3970-ddee38c19cc4
# ╠═d10152c2-824e-11eb-13f6-6baeb4aec189
# ╠═d1008464-824e-11eb-08d2-bb62d6629dc3
# ╠═d0ffcf60-824e-11eb-2608-f57deece6f4a
# ╠═cfbd8408-824e-11eb-1dc8-1b6d1d223b96
# ╠═6c77eb26-824f-11eb-0d19-e164e5f38851
# ╟─6c397e2c-824f-11eb-2866-79a94e1bce3a
# ╠═6bc0b0e6-824f-11eb-1330-31c0422a6f1c
# ╠═6b36ebfe-824f-11eb-3f16-ffd4687d05b6
# ╠═a4bfbb96-824f-11eb-0f40-9daf904940c4
# ╟─e0c2fff8-a3ca-4b7f-bf4b-4cce0aaed63e
# ╠═11c67d38-761f-407a-a897-a962a171d1a5
# ╠═f3e6f3c2-824f-11eb-204b-6997de39bb92
# ╠═a43348f0-824f-11eb-2384-db33794105c6
# ╟─b2c5e90a-8251-11eb-141d-b309e053bd5e
# ╟─6fa6f0da-8252-11eb-190b-836cd888b111
# ╠═b2a7dc28-8251-11eb-2523-21048c2ca80b
# ╠═b28be59a-8251-11eb-3a91-3996e3d04040
# ╠═b26c495e-8251-11eb-1d36-a31212b92f01
# ╟─b24a0dda-8251-11eb-1904-23fcfbed48fe
# ╠═b229ae00-8251-11eb-35c0-a3709955aa50
# ╟─c95f8c89-200f-4dd3-8d0f-21e2df9f455e
# ╠═0435d5ba-8253-11eb-1b84-a7c2f752aa4c
# ╠═04246974-8253-11eb-1415-cfd21ba19213
# ╠═03f7e1b0-8253-11eb-1acf-4fbfa23b2d98
# ╟─03aefc98-8253-11eb-1b8a-c3a3d9d642bf
# ╠═b1d52470-8251-11eb-231c-b3287d3af027
# ╠═b161cf5e-8251-11eb-2885-99e9b56e6d9f
# ╟─049d3084-8253-11eb-0324-b5f563aff8f3
# ╠═049570d0-8253-11eb-2d1d-35cacf8c0597
# ╟─e81a6060-8254-11eb-3608-25569cd3a40f
# ╠═b59da87c-8254-11eb-0823-3f1bedd509e0
# ╠═b565c036-8254-11eb-2472-758e00842f4b
# ╠═046fb640-8253-11eb-18fa-b34bef08ad65
# ╟─5ed138fe-8256-11eb-39f1-371d2390dc3b
# ╠═49799d40-8256-11eb-2f49-4d3e6ca8e337
# ╠═0921c9a9-b452-48f4-8d31-999384d1957f
# ╠═492a1200-8256-11eb-25ea-2fd41050493f
# ╟─a03ee0f6-8261-11eb-3fda-c1e1c7e294dd
# ╠═a02b04dc-8261-11eb-28a4-5975841e3647
# ╟─de8f97de-8262-11eb-371f-67987e1b8d6e
# ╠═c442a2c0-8262-11eb-313f-a3e2936b7aa5
# ╟─a00c721a-8261-11eb-1bec-1f438963b38a
# ╠═f8bfc65e-8262-11eb-1d53-6d11a6bd70cf
# ╠═f8844dfe-8262-11eb-1dab-65376333ce1e
# ╠═f85ff918-8262-11eb-26e3-fb87245d3238
# ╟─807b8d9c-8265-11eb-21bd-83508a1ae74c
# ╠═a27fda58-8265-11eb-3237-3996e53f82c1
# ╠═a2420af0-8265-11eb-1372-6b767e5c2a64
# ╟─666f0b08-8266-11eb-201d-4354eb9cae08
