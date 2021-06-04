## Comment and Uncomment
The following trick is actually quite **universal** -- Not only applicable to `Pluto`, but also
`jupyter notebook`, PyCharm, etc. **`Ctrl-/`** is the trick

- To comment multiple lines:
  - Visually select the text
  - Press `Ctrl-/` (i.e. `Ctrl` plus **slash**)
- To uncomment multiple lines is the same.
  - Visually select the (commented) text
  - Press `Ctrl-/`


### YouTube
```julia
html"""
<iframe width="100%" height="450px" src="https://www.youtube.com/embed/Yx055xdSkx0?rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""
```

# About `print` and `println` in Julia
Note that it is not that `Pluto` does not print; instead, when you write `print` or `println` in
`Pluto` cell, the output just **does not appear** in the notebook, but it **appears in the terminal** from which you launched `Pluto`.


