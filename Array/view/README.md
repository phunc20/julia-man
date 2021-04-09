
### A `view` can not be `push!`ed
See the following example.
```julia
julia> A
10-element Array{Float64,1}:
 0.39380667760972
 0.6578239314194401
 0.869181869899665
 0.661821489294514
 0.5657537633132221
 0.1801647067767489
 0.294905010954728
 0.1881865817366124
 0.07147351408326075
 0.57747073272073

julia> S1 = A[1:3]
3-element Array{Float64,1}:
 0.39380667760972
 0.6578239314194401
 0.869181869899665

julia> S1[1] = 100; S1[1], A[1]
(100, 0.39380667760972)

julia> push!(S1, -77)
4-element Array{Float64,1}:
 100.0
   0.6578239314194401
   0.869181869899665
 -77.0

julia> S1
4-element Array{Float64,1}:
 100.0
   0.6578239314194401
   0.869181869899665
 -77.0

julia> A
10-element Array{Float64,1}:
 0.39380667760972
 0.6578239314194401
 0.869181869899665
 0.661821489294514
 0.5657537633132221
 0.1801647067767489
 0.294905010954728
 0.1881865817366124
 0.07147351408326075
 0.57747073272073

julia> S2 = view(A, 1:3)
3-element view(::Array{Float64,1}, 1:3) with eltype Float64:
 0.39380667760972
 0.6578239314194401
 0.869181869899665

julia> S2[1] = 3.14159
3.14159

julia> S2[1], A[1]
(3.14159, 3.14159)

julia> push!(S2, 2.71828)
ERROR: MethodError: no method matching resize!(::SubArray{Float64,1,Array{Float64,1},Tuple{UnitRange{Int64}},true}, ::Int64)
Closest candidates are:
  resize!(::Array{T,1} where T, ::Integer) at array.jl:1082
  resize!(::BitArray{1}, ::Integer) at bitarray.jl:799
Stacktrace:
 [1] _append!(::SubArray{Float64,1,Array{Float64,1},Tuple{UnitRange{Int64}},true}, ::Base.HasLength, ::Tuple{Float64}) at ./array.jl:987
 [2] append!(::SubArray{Float64,1,Array{Float64,1},Tuple{UnitRange{Int64}},true}, ::Tuple{Float64}) at ./array.jl:981
 [3] push!(::SubArray{Float64,1,Array{Float64,1},Tuple{UnitRange{Int64}},true}, ::Float64) at ./array.jl:982
 [4] top-level scope at REPL[18]:1
```

