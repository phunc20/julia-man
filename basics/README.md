## Some Basic Usages

|Julia|Python
|-----|------
|`?obj` | `help(obj)`
|`dump(obj)` | `print(repr(obj))`
|`names(FooModule)` | `dir(foo_module)`
|`methodswith(SomeType)` | `dir(SomeType)`
|`@which func` | `func.__module__`
|`apropos("bar")` | Search for `"bar"` in docstrings of all installed packages
|`typeof(obj)` | `type(obj)`
|`obj isa SomeType`<br />or<br />`isa(obj, SomeType)` | `isinstance(obj, SomeType)`


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










