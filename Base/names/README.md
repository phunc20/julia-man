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

Note that `varinfo` (from `InteractiveUtils`) can also achieve similar goals. You can
specify the Module and a regex string for search.
```
julia> varinfo()
  name                    size summary
  –––––––––––––––– ––––––––––– –––––––
  Base                         Module
  Core                         Module
  InteractiveUtils 196.988 KiB Module
  Main                         Module
  ans                          Module
  card1                 1 byte Card
  card2                 1 byte Card
  card3                 1 byte Card

julia> varinfo(Main, r"card*")
  name    size summary
  ––––– –––––– –––––––
  card1 1 byte Card
  card2 1 byte Card
  card3 1 byte Card

```

