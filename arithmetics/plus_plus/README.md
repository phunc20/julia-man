In Julia there is no such a thing as `a++` for incrementing a variable `a`.

```julia
julia> a = 10
10

julia> a++
       ;
ERROR: syntax: unexpected ";"
Stacktrace:
 [1] top-level scope at none:1

julia> ++a
ERROR: syntax: "++" is not a unary operator
Stacktrace:
 [1] top-level scope at none:1
```

Note that neither do we have `a++` in Python:
```python
In [1]: a = 10

In [2]: a++
  File "<ipython-input-2-22e3d6dc1353>", line 1
    a++
       ^
SyntaxError: invalid syntax


In [3]: ++a
Out[3]: 10

In [4]: a
Out[4]: 10

```

