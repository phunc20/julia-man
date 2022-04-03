```julia
julia> typeof(0.01f0)
Float32

julia> typeof(0.010)
Float64

julia> typeof(0.01f0)
Float32

julia> typeof(0.01f)
ERROR: UndefVarError: f not defined
Stacktrace:
 [1] top-level scope
   @ REPL[12]:1
 [2] top-level scope
   @ ~/.julia/packages/CUDA/sCev8/src/initialization.jl:52

julia> typeof(0.01f1)
Float32

julia> typeof(0.01f2)
Float32

julia> typeof(0.01f3)
Float32
```
