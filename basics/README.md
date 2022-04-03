## Some Basic Usages
- `using`
  - To `using` multiple packages, separate them by commas: `using Pluto, PlutoUI, Flux, DifferentialEquations`
- repeat REPL's/notebook cells' last output: Unlike Python's `_`, Julia uses **`ans`**.
- comment code
  ```julia
  # Single-line comment
  #=
  Multi-
  line
  comment
  =#
  ```
- `pathof` can be used to inspect the path of an installed package.
  ```julia
  julia> using Example
  
  julia> pathof(Example)
  "/home/phunc20/.julia/packages/Example/aqsx3/src/Example.jl"
  
  julia> using Pluto
  
  julia> pathof(Pluto)
  "/home/phunc20/.julia/packages/Pluto/8cQn7/src/Pluto.jl"
  ```









