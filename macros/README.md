
## Some Common Macros
- `@which` and `@edit`.
  ```julia
  a = 1.0 + 2.0im
  b = -2.0 + 2im
  @which a * b
  @edit a * b
  ```
- `@doc`
  - The docstring is placed just before the definition of the function. To retrieve a function's docstring, say, the function `square`, use `@doc square`. Here are a few examples:
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






## Convenience functions
```julia
function with_terminal(f)
  local spam_out, spam_err
  @color_output false begin
    spam_out = @capture_out begin
      spam_err = @capture_err begin
        f()
      end
    end
  end
  spam_out, spam_err

  HTML("""
    <style>
    div.vintage_terminal {

    }
    div.vintage_terminal pre {
      color: #ddd;
      background-color: #333;
      border: 5px solid pink;
      font-size: .75rem;
    }

    </style>
  <div class="vintage_terminal">
    <pre>$(Markdown.htmlesc(spam_out))</pre>
  </div>
  """)
end


with_terminal() do
  @code_llvm debuginfo=:none a * c
end

with_terminal() do
  @code_native a * c
end
```





