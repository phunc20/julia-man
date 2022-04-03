Loss functions in `Flux` are grouped together in the `Flux.Losses` module.
However, for convenience, it seems that the developpers created aliases:
```julia
julia> Flux.mae == Flux.Losses.mae
true

julia> Flux.crossentropy == Flux.Losses.crossentropy
true
```
