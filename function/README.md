- Anonymous
    - Argument
        - Observe the following example in REPL:
          ```julia
          julia> rotate(θ) = ((x,y),) -> (cos(θ)x - sin(θ)y, sin(θ)x + cos(θ)y)
          rotate (generic function with 1 method)
          
          julia> rotate(π/2)((3,4))
          (-4.0, 3.0000000000000004)
          
          julia> rotate(π/2)([3,4])
          (-4.0, 3.0000000000000004)
          ```
          It's natural for a Julia beginner to ask, "Why we need
          the comma in `((x,y), )`" of the anonymous function's arg?  
          Well, let's try w/o it to see what'd happen:
          ```julia
          julia> rotate(θ) = ((x,y)) -> (cos(θ)x - sin(θ)y, sin(θ)x + cos(θ)y)
          rotate (generic function with 1 method)
          
          julia> rotate(π/2)(3,4)
          (-4.0, 3.0000000000000004)
          
          julia> rotate(π/2)((3,4))
          ERROR: MethodError: no method matching (::var"#1#2"{Float64})(::Tuple{Int64, Int64})
          Closest candidates are:
            (::var"#1#2")(::Any, ::Any) at REPL[7]:1
          Stacktrace:
           [1] top-level scope
             @ REPL[9]:1
          
          julia> rotate(θ) = ([x,y]) -> (cos(θ)x - sin(θ)y, sin(θ)x + cos(θ)y)
          ERROR: syntax: "[x, y]" is not a valid function argument name around REPL[10]:1
          Stacktrace:
           [1] top-level scope
             @ REPL[10]:1
          ```
          The reason for this is actually simple: The parentheses here works just like
          in Python -- `(sth)` equals to the same `sth`.
          ```julia
          julia> typeof(((1,2,3)))
          Tuple{Int64, Int64, Int64}
          
          julia> typeof((1,2,3))
          Tuple{Int64, Int64, Int64}
          
          julia> #typeof((1,2,3))
          
          julia> typeof(((1,2,3),))
          Tuple{Tuple{Int64, Int64, Int64}}
          
          julia> typeof(([1,2,3]))
          Vector{Int64} (alias for Array{Int64, 1})
          
          julia> typeof([1,2,3])
          Vector{Int64} (alias for Array{Int64, 1})
          ```
          I hope this illustrates well the point that I aim to emphasize, i.e.  
          **the input arg** of the anonymous function **needs to be a `Tuple`**
          (and a `Tuple` of a single item should be written as `(first_item,)`
          instead of `(first_item)`.)
