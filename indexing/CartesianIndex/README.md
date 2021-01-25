
julia> A = reshape(1:32, 4, 4, 2)
4×4×2 reshape(::UnitRange{Int64}, 4, 4, 2) with eltype Int64:
[:, :, 1] =
 1  5   9  13
 2  6  10  14
 3  7  11  15
 4  8  12  16

[:, :, 2] =
 17  21  25  29
 18  22  26  30
 19  23  27  31
 20  24  28  32

julia> A[3,2,1]
7

julia> A[CartesianIndex(3,2,1)] == A[3,2,1] == 7
true

julia> page = A[:,:,1]
4×4 Array{Int64,2}:
 1  5   9  13
 2  6  10  14
 3  7  11  15
 4  8  12  16

julia> page[CartesianIndex(1,1), CartesianIndex(2,2)]
ERROR: BoundsError: attempt to access 4×4 Array{Int64,2} at index [1, 1, 2, 2]
Stacktrace:
 [1] getindex at ./array.jl:810 [inlined]
 [2] getindex(::Array{Int64,2}, ::CartesianIndex{2}, ::CartesianIndex{2}) at ./multidimensional.jl:557
 [3] top-level scope at REPL[5]:1

julia> page[[CartesianIndex(1,1), CartesianIndex(2,2), CartesianIndex(3,3), CartesianIndex(4,4)]]
4-element Array{Int64,1}:
  1
  6
 11
 16

julia> axes(A,1)
Base.OneTo(4)

julia> axes(A)
(Base.OneTo(4), Base.OneTo(4), Base.OneTo(2))

julia> axes(A,2)
Base.OneTo(4)

julia> OneTo(4)
ERROR: UndefVarError: OneTo not defined
Stacktrace:
 [1] top-level scope at REPL[10]:1

julia> oneto(4)
ERROR: UndefVarError: oneto not defined
Stacktrace:
 [1] top-level scope at REPL[11]:1

julia> CartesianIndex.(Base.OneTo(4))
4-element Array{CartesianIndex{1},1}:
 CartesianIndex(1,)
 CartesianIndex(2,)
 CartesianIndex(3,)
 CartesianIndex(4,)

julia> CartesianIndex.(Base.OneTo(4), Base.OneTo(3))
ERROR: DimensionMismatch("arrays could not be broadcast to a common size; got a dimension with lengths 4 and 3")
Stacktrace:
 [1] _bcs1 at ./broadcast.jl:501 [inlined]
 [2] _bcs at ./broadcast.jl:495 [inlined]
 [3] broadcast_shape at ./broadcast.jl:489 [inlined]
 [4] combine_axes at ./broadcast.jl:484 [inlined]
 [5] instantiate at ./broadcast.jl:266 [inlined]
 [6] materialize(::Base.Broadcast.Broadcasted{Base.Broadcast.DefaultArrayStyle{1},Nothing,Type{CartesianIndex},Tuple{Base.OneTo{Int64},Base.OneTo{Int64}}}) at ./broadcast.jl:837
 [7] top-level scope at REPL[13]:1

julia> CartesianIndex.(Base.OneTo(4), Base.OneTo(4))
4-element Array{CartesianIndex{2},1}:
 CartesianIndex(1, 1)
 CartesianIndex(2, 2)
 CartesianIndex(3, 3)
 CartesianIndex(4, 4)

julia> CartesianIndex.(Base.OneTo(4), Base.OneTo(4).+3)
4-element Array{CartesianIndex{2},1}:
 CartesianIndex(1, 4)
 CartesianIndex(2, 5)
 CartesianIndex(3, 6)
 CartesianIndex(4, 7)

julia> CartesianIndex.(axes(A,1), axes(A,2), 1)
4-element Array{CartesianIndex{3},1}:
 CartesianIndex(1, 1, 1)
 CartesianIndex(2, 2, 1)
 CartesianIndex(3, 3, 1)
 CartesianIndex(4, 4, 1)

julia> A[CartesianIndex.(axes(A,1), axes(A,2), 1)]
4-element Array{Int64,1}:
  1
  6
 11
 16

julia> A[CartesianIndex.(axes(A,1), axes(A,2), :)]
ERROR: MethodError: no method matching CartesianIndex(::Int64, ::Int64, ::Colon)
Closest candidates are:
  CartesianIndex(::Integer...) at multidimensional.jl:69
  CartesianIndex(::Union{Integer, CartesianIndex}...) at multidimensional.jl:76
Stacktrace:
 [1] _broadcast_getindex_evalf at ./broadcast.jl:648 [inlined]
 [2] _broadcast_getindex at ./broadcast.jl:621 [inlined]
 [3] getindex at ./broadcast.jl:575 [inlined]
 [4] copy at ./broadcast.jl:876 [inlined]
 [5] materialize(::Base.Broadcast.Broadcasted{Base.Broadcast.DefaultArrayStyle{1},Nothing,Type{CartesianIndex},Tuple{Base.OneTo{Int64},Base.OneTo{Int64},Base.RefValue{Colon}}}) at ./broadcast.jl:837
 [6] top-level scope at REPL[18]:1

julia> A[CartesianIndex.(axes(A,1), axes(A,2)), :]
4×2 Array{Int64,2}:
  1  17
  6  22
 11  27
 16  32

julia> A[CartesianIndex.(axes(A,1), axes(A,2)), :end]
ERROR: ArgumentError: invalid index: :end of type Symbol
Stacktrace:
 [1] to_index(::Symbol) at ./indices.jl:297
 [2] to_index(::Base.ReshapedArray{Int64,3,UnitRange{Int64},Tuple{}}, ::Symbol) at ./indices.jl:274
 [3] to_indices at ./indices.jl:325 [inlined]
 [4] to_indices at ./multidimensional.jl:713 [inlined]
 [5] to_indices at ./indices.jl:321 [inlined]
 [6] getindex(::Base.ReshapedArray{Int64,3,UnitRange{Int64},Tuple{}}, ::Array{CartesianIndex{2},1}, ::Symbol) at ./abstractarray.jl:1060
 [7] top-level scope at REPL[20]:1

julia> A[1, 2, :end]
ERROR: ArgumentError: invalid index: :end of type Symbol
Stacktrace:
 [1] to_index(::Symbol) at ./indices.jl:297
 [2] to_index(::Base.ReshapedArray{Int64,3,UnitRange{Int64},Tuple{}}, ::Symbol) at ./indices.jl:274
 [3] to_indices at ./indices.jl:325 [inlined] (repeats 3 times)
 [4] to_indices at ./indices.jl:321 [inlined]
 [5] getindex(::Base.ReshapedArray{Int64,3,UnitRange{Int64},Tuple{}}, ::Int64, ::Int64, ::Symbol) at ./abstractarray.jl:1060
 [6] top-level scope at REPL[21]:1

julia> A[1, 2, :]
2-element Array{Int64,1}:
  5
 21

julia> A[1, 2:end, :]
3×2 Array{Int64,2}:
  5  21
  9  25
 13  29

julia> A[1, 2:end, 1:end]
3×2 Array{Int64,2}:
  5  21
  9  25
 13  29

julia> A[1, 2, 1:end]
2-element Array{Int64,1}:
  5
 21

julia> A[1, 2, :]
2-element Array{Int64,1}:
  5
 21

julia> A[1, 2, 1:]
ERROR: syntax: missing last argument in "1:" range expression
Stacktrace:
 [1] top-level scope at none:1

julia> A[1, 2, :end]
ERROR: ArgumentError: invalid index: :end of type Symbol
Stacktrace:
 [1] to_index(::Symbol) at ./indices.jl:297
 [2] to_index(::Base.ReshapedArray{Int64,3,UnitRange{Int64},Tuple{}}, ::Symbol) at ./indices.jl:274
 [3] to_indices at ./indices.jl:325 [inlined] (repeats 3 times)
 [4] to_indices at ./indices.jl:321 [inlined]
 [5] getindex(::Base.ReshapedArray{Int64,3,UnitRange{Int64},Tuple{}}, ::Int64, ::Int64, ::Symbol) at ./abstractarray.jl:1060
 [6] top-level scope at REPL[28]:1

julia>
