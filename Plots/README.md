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





I wanted to draw $B_p$ for $p$-norm.
Cf. [https://docs.juliaplots.org/latest/generated/plotly/](https://docs.juliaplots.org/latest/generated/plotly/)





