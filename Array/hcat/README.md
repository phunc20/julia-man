## `hcat` and `vcat`
Here is how to use `hcat` and `vcat` in a basic way:
```julia
julia> 0:5
0:5

julia> hcat(0:5)
6×1 Matrix{Int64}:
 0
 1
 2
 3
 4
 5

julia> vcat(0:5)
6-element Vector{Int64}:
 0
 1
 2
 3
 4
 5

julia> hcat(0:5...)
1×6 Matrix{Int64}:
 0  1  2  3  4  5

julia> hcat(0,1,2,3,4,5)
1×6 Matrix{Int64}:
 0  1  2  3  4  5

julia> vcat(0:5...)
6-element Vector{Int64}:
 0
 1
 2
 3
 4
 5

julia> ndims(0:5)
1

julia> ndims(vcat(0:5))
1

julia> ndims(hcat(0:5))
2

julia> ndims(hcat(0:5...))
2

julia> hcat(1:5, 6:10)
5×2 Matrix{Int64}:
 1   6
 2   7
 3   8
 4   9
 5  10

julia> vcat(1:5, 6:10)
10-element Vector{Int64}:
  1
  2
  3
  4
  5
  6
  7
  8
  9
 10
```
