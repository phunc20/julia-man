- `Base.show_supertypes()`
  - Julia implicitly runs `using Core` and `using Base` when starting the REPL. However, the `show_supertypes()` function is not exported by the `Base` module, thus you cannot access it by just typing `show_supertypes(Float64)`. Instead, you have to specify the module name: `Base.show_supertypes(Float64)`.
  ```julia
  julia> Base.show_supertypes(Int64)
  Int64 <: Signed <: Integer <: Real <: Number <: Any
  ```


