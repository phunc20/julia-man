The following example demonstrates a useful pattern to combine plots:
01. Create a new plot and store it in a variable
01. Modify that plot to add more elements
01. Return the plot
```julia
function sin_cos_plot()
    T = -1.0:0.01:1.0

    result = plot(T, sin.(T))
    plot!(result, T, cos.(T))
    plot!(result, T, tan.(T))

    return result
end
```

## Dark Viewer
Set in `plot()` the following:
```julia
background_color=:black,
foreground_color=:white,
```
Cf. <https://docs.juliaplots.org/latest/colors/>


## Useful Parameter Settings
```julia
aspect_ratio=:equal,
legend=false,
background_color=:black,
foreground_color=:white,
```


I wanted to draw $B_p$ for $p$-norm.
Cf. [https://docs.juliaplots.org/latest/generated/plotly/](https://docs.juliaplots.org/latest/generated/plotly/)


## Usage Notes
- `plot()` syntax
    - Multiple functions in the same range
      ```julia
      using Distributions
      relu(x) = max(x, 0)
      leaky_relu(x) = max(x, 0) + min(0.01x, 0)
      gelu(x) = x * cdf(Normal(), x)
      sigmoid(x) = 1 / (1 + ℯ^(-x))
      swish(x) = x * sigmoid(x)
      softplus(x) = log(1 + ℯ^x)
      activation_fns = [
          relu,
          leaky_relu,
          gelu,
          sigmoid,
          swish,
          softplus,
      ]
      
      x = -10:0.1:10
      string_fns = [string(fn) for fn in activation_fns]
      plot(
          activation_fns,
          x,
          label=reshape(string_fns, 1, :),
          legend=:left,
          background_color=:black,
      )
      ```
- Backends
    - `plotly()` allows, among other things, to choose to (un)display a curve.
- labels
    - The `label` or `labels` input arg to the `plot` function needs to be
      a **`Matrix`** and **not a `Vector`**.  
      For example, `["a" "b" "c"]` is a `1×3 Matrix{String}`
      whereas `["a", "b", "c"]` is a
      `Vector{String} (alias for Array{String, 1})`. In particular,
      python-like list comprehension creates a `Vector` instead of a `Matrix`.
      As a remedy, one could use the `reshape` function to convert a `Vector`
      to a `Matrix`, e.g. `reshape(["a", "b", "c"], 1, :)` gives the same
      `Matrix` as `["a" "b" "c"]`.
    - Simply being a `Matrix` is **not enough**. The shape is equally important.
      It has to be of shape `1 by n`.  
      Indeed, using the same abc string example above,
      `reshape(["a", "b", "c"], :, 1)` won't correctly display labels.
- legend
    - An example:
      ```julia
      using Plots
      plot(randn(10,3),legend=:bottomleft)
      ```
    - The available keywords for legend are `:right`, `:left`, `:top`, `:bottom`,
      `:inside`, `:best`, `:legend`, `:topright`, `:topleft`,
      `:bottomleft`, `:bottomright`.
