```julia
julia> @enum InfectionStatus S I R

julia> test_status = S
S::InfectionStatus = 0

julia> test_status
S::InfectionStatus = 0

julia> typeof(test_status)
Enum InfectionStatus:
S = 0
I = 1
R = 2

julia> Integer(S), Integer(I), Integer(R)
(0, 1, 2)

julia>
```
