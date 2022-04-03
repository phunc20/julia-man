## Version Number Literals
```julia
julia> v"0.2" == v"0.2.0"
true

julia> v"0.2" === v"0.2.0"
true

julia> v"2" === v"2.0.0"
true

julia> VERSION
v"1.7.1"

julia> v"0.3.0-rc1" < v"0.3"
true

julia> v"0.3.0-rc1" < v"0.3-"
false
```
