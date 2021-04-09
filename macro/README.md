- `@doc`
  - The docstring is placed just before the definition of the function. To retrieve a function's docstring, use `@doc square`.
    ```julia
    "Compute the square of number x"
    square(x::Number) = x^2
    ```
  - A full-blown example
    ```julia
    """
        cube(x::Number)
    
    Compute the cube of `x`.
    
    # Examples
    ```julia-repl
    julia> cube(5)
    125
    julia> cube(im)
    0 - 1im
    ```
    """
    cube(x) = x^3
    ```










