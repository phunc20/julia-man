

## Slicing
Let's see an example.
```julia
julia> A = rand(10)
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

julia> subA = A[:3]
0.869181869899665

julia> subA = A[1:3]
3-element Array{Float64,1}:
 0.39380667760972
 0.6578239314194401
 0.869181869899665

julia> subA[1] = 100; subA - A[1:3] 
3-element Array{Float64,1}:
 99.60619332239028
  0.0
  0.0
```

- slicing gives a **copy**
  - To not copy, cf. `./view/`
- slicing has to specify both the starting and the ending indices
  - e.g.
    ```julia
    julia> A[begin]
    0.39380667760972
    
    julia> A[end]
    0.57747073272073
    
    julia> A[:end]
    ERROR: ArgumentError: invalid index: :end of type Symbol
    Stacktrace:
     [1] to_index(::Symbol) at ./indices.jl:297
     [2] to_index(::Array{Float64,1}, ::Symbol) at ./indices.jl:274
     [3] to_indices at ./indices.jl:325 [inlined]
     [4] to_indices at ./indices.jl:322 [inlined]
     [5] getindex(::Array{Float64,1}, ::Symbol) at ./abstractarray.jl:1060
     [6] top-level scope at REPL[9]:1
    ```



