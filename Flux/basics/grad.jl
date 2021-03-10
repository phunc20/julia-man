### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 8ce76b60-8197-11eb-2ba0-1fbd56efda05
using Flux

# ╔═╡ 87e0fa16-8195-11eb-1390-1740676ce3a0
path_tmp = mktempdir()

# ╔═╡ db37122a-8197-11eb-1cbf-29fc1bcadf1f
typeof(path_tmp)

# ╔═╡ 8d070ed4-8197-11eb-1ca9-f5354be2ffbd
begin
  import Pkg
  Pkg.activate(path_tmp)
  Pkg.add([
    "Flux"
  ])
end

# ╔═╡ d2130040-81b8-11eb-1475-0b09814b3f1b
md"## Taking Gradients"

# ╔═╡ 814b60ca-8199-11eb-36f6-8f46f90b8b4f
f(x) = 3x^2 + 2x + 1

# ╔═╡ b32bb1e4-8199-11eb-3a2b-5b84551b25fc
∇f(x) = gradient(f, x)[1]  # df/dx = 6x + 2

# ╔═╡ cab491ce-81af-11eb-104e-235b93a73465
md"""
If we inspect `typeof(gradient(f, x))`, then we'll get the following error message:
```
UndefVarError: x not defined
```
As you might already come to think, the expression **`∇f(x) = gradient(f, x)[1]`** defines a function (of `x`)
and that's why our inspection is being complained about not having specified `x`.
"""

# ╔═╡ 8b10377e-819f-11eb-2192-a7e3752fca70
∇f(2)

# ╔═╡ 061d9944-81b3-11eb-1168-956e97f2c08c
md"""
The following might help you understand why `[1]` was used above.
"""

# ╔═╡ e68afab8-81b2-11eb-181e-57ca41e0499a
unknown_fn(x) = gradient(f,x)

# ╔═╡ f1e9fc74-81b2-11eb-24e5-a1b108bd1447
unknown_fn(2)

# ╔═╡ fd2a6966-81b2-11eb-1dd2-b76db5f23d58
typeof(unknown_fn(2))

# ╔═╡ 20a73a86-81b3-11eb-3e16-8d5e4515bb79
md"Let's differentiate once more."

# ╔═╡ b8fe595a-81b2-11eb-2b8c-63f6a9dfb2e9
∇²f(x) = gradient(∇f, x)[1]  # d²f/dx² = 6

# ╔═╡ b8db14b0-81b2-11eb-2c54-4966a6093c71
∇²f(3.14159)

# ╔═╡ 7fa826d0-81b3-11eb-3184-09d566e31674
md"""
It is not mandatory to use `gradient()` through defining a function like we did before. Instead, we can use `gradient()` with constant input args as follows.
"""

# ╔═╡ b8b1cd2e-81b2-11eb-32b4-bd8c62b6133a
g(x, y) = sum((x .- y).^2)

# ╔═╡ b85ced88-81b2-11eb-18be-4da0e21d7c6a
gradient(g, [2,1], [2,0])

# ╔═╡ c8ec8320-81b3-11eb-3886-8535bfbc54b2
md"""
Let's verify if this is correct:$(HTML("<br>"))

$g(x,y) = \sum_{i=1}^{n} (x_i - y_i)^2 = || x - y ||^{2}\,.$

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
and that we need to specify the gradient at some point:
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

# ╔═╡ 2262e6d8-81bb-11eb-3970-ddee38c19cc4
md"""
## Simple Models
"""

# ╔═╡ Cell order:
# ╠═87e0fa16-8195-11eb-1390-1740676ce3a0
# ╠═db37122a-8197-11eb-1cbf-29fc1bcadf1f
# ╠═8d070ed4-8197-11eb-1ca9-f5354be2ffbd
# ╠═8ce76b60-8197-11eb-2ba0-1fbd56efda05
# ╟─d2130040-81b8-11eb-1475-0b09814b3f1b
# ╠═814b60ca-8199-11eb-36f6-8f46f90b8b4f
# ╠═b32bb1e4-8199-11eb-3a2b-5b84551b25fc
# ╟─cab491ce-81af-11eb-104e-235b93a73465
# ╠═8b10377e-819f-11eb-2192-a7e3752fca70
# ╟─061d9944-81b3-11eb-1168-956e97f2c08c
# ╠═e68afab8-81b2-11eb-181e-57ca41e0499a
# ╠═f1e9fc74-81b2-11eb-24e5-a1b108bd1447
# ╠═fd2a6966-81b2-11eb-1dd2-b76db5f23d58
# ╟─20a73a86-81b3-11eb-3e16-8d5e4515bb79
# ╠═b8fe595a-81b2-11eb-2b8c-63f6a9dfb2e9
# ╠═b8db14b0-81b2-11eb-2c54-4966a6093c71
# ╟─7fa826d0-81b3-11eb-3184-09d566e31674
# ╠═b8b1cd2e-81b2-11eb-32b4-bd8c62b6133a
# ╠═b85ced88-81b2-11eb-18be-4da0e21d7c6a
# ╟─c8ec8320-81b3-11eb-3886-8535bfbc54b2
# ╟─b8190986-81b2-11eb-2605-f79e1cc310dc
# ╠═ce7809f4-81ba-11eb-1d04-231c2fb609a9
# ╠═c9142f50-81b9-11eb-04b8-afafe176c23f
# ╠═b7e4e306-81ba-11eb-2884-cbe7102a9fb1
# ╠═d8f58d02-81ba-11eb-026b-ed82844e7051
# ╟─ef711a12-819d-11eb-074d-897cd7b3f324
# ╟─2262e6d8-81bb-11eb-3970-ddee38c19cc4
