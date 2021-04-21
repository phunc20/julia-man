## At Least Two Syntaxes for A Range
- `in`
- `=`
```julia
julia> for i = 1:5
         println(i)
       end
1
2
3
4
5

julia> for i in 1:5
         println(i)
       end
1
2
3
4
5
```


## Increasing/Decreasing Indices
- Correct syntax is **`for i = num1:increment:num2`**
  - `for i = num1:num2` est sous-entendu avec `increment = 1`
```julia
julia> for i = 10:1
         println(i)
        end

julia> for i = 1:10
         println(i)
        end
1
2
3
4
5
6
7
8
9
10

julia> for i = 10:1:-1
         println(i)
        end

julia> for i = 10:-1:1
         println(i)
        end
10
9
8
7
6
5
4
3
2
1

julia>
```
