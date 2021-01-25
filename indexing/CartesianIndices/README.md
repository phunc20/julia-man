R for Range

CartesianIndices(sz::Dims) -> R
CartesianIndices((istart:istop, jstart:jstop, ...)) -> R

CartesianIndices(A::AbstractArray) -> R


julia> fill(1,(2,3))
2×3 Array{Int64,2}:
 1  1  1
 1  1  1

julia> zeros((2,3))
2×3 Array{Float64,2}:
 0.0  0.0  0.0
 0.0  0.0  0.0

julia> CartesianIndices(fill(1,(2,3)))
2×3 CartesianIndices{2,Tuple{Base.OneTo{Int64},Base.OneTo{Int64}}}:
 CartesianIndex(1, 1)  CartesianIndex(1, 2)  CartesianIndex(1, 3)
 CartesianIndex(2, 1)  CartesianIndex(2, 2)  CartesianIndex(2, 3)

julia> CartesianIndices(zeros((2,3)))
2×3 CartesianIndices{2,Tuple{Base.OneTo{Int64},Base.OneTo{Int64}}}:
 CartesianIndex(1, 1)  CartesianIndex(1, 2)  CartesianIndex(1, 3)
 CartesianIndex(2, 1)  CartesianIndex(2, 2)  CartesianIndex(2, 3)

julia> CartesianIndices(fill(1,(2,3))) == CartesianIndices(zeros((2,3)))
true

julia> foreach(println, CartesianIndices((2,2,2)))
CartesianIndex(1, 1, 1)
CartesianIndex(2, 1, 1)
CartesianIndex(1, 2, 1)
CartesianIndex(2, 2, 1)
CartesianIndex(1, 1, 2)
CartesianIndex(2, 1, 2)
CartesianIndex(1, 2, 2)
CartesianIndex(2, 2, 2)

julia> CartesianIndices(1:2,4:6,7:9)
ERROR: MethodError: no method matching CartesianIndices(::UnitRange{Int64}, ::UnitRange{Int64}, ::UnitRange{Int64})
Closest candidates are:
  CartesianIndices(::AbstractArray) at multidimensional.jl:264
Stacktrace:
 [1] top-level scope at REPL[35]:1

julia> CartesianIndices((1:2,4:6,7:9))
2×3×3 CartesianIndices{3,Tuple{UnitRange{Int64},UnitRange{Int64},UnitRange{Int64}}}:
[:, :, 1] =
 CartesianIndex(1, 4, 7)  CartesianIndex(1, 5, 7)  CartesianIndex(1, 6, 7)
 CartesianIndex(2, 4, 7)  CartesianIndex(2, 5, 7)  CartesianIndex(2, 6, 7)

[:, :, 2] =
 CartesianIndex(1, 4, 8)  CartesianIndex(1, 5, 8)  CartesianIndex(1, 6, 8)
 CartesianIndex(2, 4, 8)  CartesianIndex(2, 5, 8)  CartesianIndex(2, 6, 8)

[:, :, 3] =
 CartesianIndex(1, 4, 9)  CartesianIndex(1, 5, 9)  CartesianIndex(1, 6, 9)
 CartesianIndex(2, 4, 9)  CartesianIndex(2, 5, 9)  CartesianIndex(2, 6, 9)

julia> cartesian = CartesianIndices((1:3, 1:2))
3×2 CartesianIndices{2,Tuple{UnitRange{Int64},UnitRange{Int64}}}:
 CartesianIndex(1, 1)  CartesianIndex(1, 2)
 CartesianIndex(2, 1)  CartesianIndex(2, 2)
 CartesianIndex(3, 1)  CartesianIndex(3, 2)

julia> cartesian[4]
CartesianIndex(1, 2)

julia> CIs = CartesianIndices((2:3, 5:6))
2×2 CartesianIndices{2,Tuple{UnitRange{Int64},UnitRange{Int64}}}:
 CartesianIndex(2, 5)  CartesianIndex(2, 6)
 CartesianIndex(3, 5)  CartesianIndex(3, 6)

julia> CI = CartesianIndex(3, 4)
CartesianIndex(3, 4)

julia> CIs .- CI
2×2 CartesianIndices{2,Tuple{UnitRange{Int64},UnitRange{Int64}}}:
 CartesianIndex(-1, 1)  CartesianIndex(-1, 2)
 CartesianIndex(0, 1)   CartesianIndex(0, 2)

julia> CIs .+ CI
2×2 CartesianIndices{2,Tuple{UnitRange{Int64},UnitRange{Int64}}}:
 CartesianIndex(5, 9)  CartesianIndex(5, 10)
 CartesianIndex(6, 9)  CartesianIndex(6, 10)

julia>
