`abs2` may seem to be a strange name. Literally, `abs2` means taking square after taking absolute value.
Thinking about it, one soon realizes that for all real numbers `x` (i.e. for all `x` s.t. `isa(x, Real)` gives `true`),
`abs2(x)` equals `x^2`.

So why creating `abs2` when we already have `^2`? One reason is for complex numbers:
```julia
julia> abs2(im)
1

julia> im^2
-1 + 0im

julia> im^4
1 + 0im

julia> abs(im)^2
1.0

julia> typeof(abs2(im))
Int64
```
