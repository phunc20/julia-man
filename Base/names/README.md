## Utility
`names` can be used somewhat like `who` or `whos` (or even `vars(), locals(), globals()`) in Python,
i.e. to check existing varaibles. Here is an example.

```julia
julia> names(Main)[4:end]
5-element Array{Symbol,1}:
 :Main
 :ans
 :card1
 :card2
 :card3

julia> names(Main)
8-element Array{Symbol,1}:
 :Base
 :Core
 :InteractiveUtils
 :Main
 :ans
 :card1
 :card2
 :card3
```




