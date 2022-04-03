## Possible Keywords
- `in`
- `=` (usually used along with a range object like `1:3`)
- `∈`
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

julia> for i ∈ 1:5
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


## Combining Nested `for` Loops
Iterables can refer to outer loop variables:
```julia
julia> for i = 1:3, j = 1:i
         println((i,j))
       end
(1, 1)
(2, 1)
(2, 2)
(3, 1)
(3, 2)
(3, 3)
```

Some behaviours of nested loops and combined nested loop are different. Notably,
- iteration values
  ```julia
  julia> for i = 1:2, j = 3:4
           println((i,j))
           i = 0
         end
  (1, 3)
  (1, 4)
  (2, 3)
  (2, 4)
  
  julia> for i = 1:2
           for j = 3:4
             println((i,j))
             i = 0
           end
         end
  
  (1, 3)
  (0, 4)
  (2, 3)
  (0, 4)
  ```
- `break`
  ```julia
  julia> for i = 1:5, j = 1:7
           if j > 1
             break
           end
           print((i,j))
         end
  (1, 1)
  
  julia> for i = 1:5
           for j = 1:7
             if j > 1
               break
             end
             println((i,j))
           end
         end
  (1, 1)
  (2, 1)
  (3, 1)
  (4, 1)
  (5, 1)
  ```
