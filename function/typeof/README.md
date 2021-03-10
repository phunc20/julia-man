If you have a function, say `f`, and you do `typeof(f)`, you wouldn't get much information from doing that.
Indeed, here is what you'd get:
```julia
julia> a = 10
10

julia> typeof(a)
Int64

julia> f(x) = x^2
f (generic function with 1 method)

julia> typeof(f)
typeof(f)

julia> typeof(typeof)
typeof(typeof)

julia>
```
