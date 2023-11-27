## Literals
`[1 2 3 4], [1,2,3,4], [1;2;3;4], 1:4, Array(1:4)` are similar ways
to write a literal array in Julia. The following are
their differences (and similarities):
- `[1 2 3 4]` is an `Array{Int64,2}` of size `(1, 4)`
- both `[1,2,3,4]` and `[1;2;3;4]` are `Array{Int64,1}` of size `(4,)`
- To obtain the same array but with size `(4, 1)`, do
    - `[1;2;3;4;;]`
    - A few more examples:
      ```julia
      julia> [1;2;3;;4;5;6;;7;8;9]
      3×3 Matrix{Int64}:
       1  4  7
       2  5  8
       3  6  9
      
      julia> [1;2;3;;4;5;6;;7;8;9;;]
      3×3 Matrix{Int64}:
       1  4  7
       2  5  8
       3  6  9
      
      julia> [1 4 7; 2 5 8; 3 6 9]
      3×3 Matrix{Int64}:
       1  4  7
       2  5  8
       3  6  9
      ```
- `1:4` is a `UnitRange{Int64}`
- `Array(1:4)` is also `Array{Int64,1}`


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



