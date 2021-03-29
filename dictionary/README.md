## `Pair`
The key-value pairs of a Julia dictionary is foremost of type `Pair`s.
```julia
julia> D = Dict("love" => "tình yêu", "flag" => "kỳ", "turqoise" => "lam")
Dict{String,String} with 3 entries:
  "flag"     => "kỳ"
  "love"     => "tình yêu"
  "turqoise" => "lam"

julia> for p in D
         println(typeof(p))
       end
Pair{String,String}
Pair{String,String}
Pair{String,String}

julia> typeof("age" => 33)
Pair{String,Int64}

julia> k, v = "age" => 33
"age" => 33

julia> k
"age"

julia> v
33

julia> for (k, v) in D
         println("$k maps to $v")
       end
flag maps to kỳ
love maps to tình yêu
turqoise maps to lam

julia> p = "lucky number" => 42
"lucky number" => 42

julia> p
"lucky number" => 42

julia> typeof(p)
Pair{String,Int64}

julia> k, v = p
"lucky number" => 42

julia> k
"lucky number"

julia> v
42

```


## Check if a key is in a dictionary
To access a Julia dictionary's keys, there are at least two ways, say we have at our disposal
a dictionary named `fibo`.
01. `fibo.keys` returns an `Array` (somewhat like the array when we learn hashing with chaining.)
02. `keys(fibo)` returns a `Base.KeySet`

Julia does not allow `sth in Array` check, but for `Base.KeySet`, as the name suggests, it's a set and so Julia supports `sth in Base.KeySet`, like we show in the following example.
```julia
julia> fibo = Dict{Integer, Integer}(1=>1, 2=>1, 3=>2, 4=>3)
Dict{Integer,Integer} with 4 entries:
  4 => 3
  2 => 1
  3 => 2
  1 => 1

julia> fibo.keys
16-element Array{Integer,1}:
 #undef
   4
 #undef
 #undef
 #undef
   2
   3
 #undef
 #undef
 #undef
 #undef
 #undef
 #undef
 #undef
 #undef
   1

julia> 4 in fibo.keys
ERROR: UndefRefError: access to undefined reference
Stacktrace:
 [1] getindex at ./array.jl:809 [inlined]
 [2] iterate at ./array.jl:785 [inlined] (repeats 2 times)
 [3] in(::Int64, ::Array{Integer,1}) at ./operators.jl:1057
 [4] top-level scope at REPL[37]:1

julia> keys(fibo)
Base.KeySet for a Dict{Integer,Integer} with 4 entries. Keys:
  4
  2
  3
  1

julia> 4 in keys(fibo)
true

julia> 5 in keys(fibo)
false

julia>
```
