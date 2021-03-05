### `ndims()` and `size()`
```julia
julia> A = [1,2,3]
3-element Array{Int64,1}:
 1
 2
 3

julia> ndims(A)
1

julia> size(A)
(3,)

julia> A = [1 2 3]
1×3 Array{Int64,2}:
 1  2  3

julia> ndims(A)
2

julia> size(A)
(1, 3)

julia> A = [1;2;3]
3-element Array{Int64,1}:
 1
 2
 3

julia> ndims(A)
1

julia> size(A)
(3,)
```


### Subtype Relations btw Arrays
```julia
julia> Array{Int64,2} <: Array{Int64}
true

julia> Array{Int64,2} <: Array{Int64, 3}
false

julia> Array{Int64,2} <: Array{Number}
false

julia> Array{Int64,2} <: Array{Number,2}
false

julia> Int64 <: Number
true
```
