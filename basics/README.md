## Some Basic Usages

| Julia | Python |
| ----- | ------ |
| `?obj` | `help(obj)` |
| `dump(obj)` | `print(repr(obj))` |
| `names(FooModule)` | `dir(foo_module)` |
| `methodswith(SomeType)` | `dir(SomeType)` |
| `@which func` | `func.__module__` |
| `apropos("bar")` | Search for `"bar"` in docstrings of all installed packages |
| `typeof(obj)` | `type(obj)` |
| `obj isa SomeType`<br />or<br />`isa(obj, SomeType)` | `isinstance(obj, SomeType)` |

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


## More Basic Usages
| Julia | Python |
| ----- | ------ |
| `range(1, 10, step=2)` or equiv. `1:2:10` <br />`range(10, 1, step=-1)` | `range(1, 11, 2)`<br />`range(10, 2, -1)` |
| `collect(range(1, 10, step=2))` | `list(range(1, 11, 2))` |
| `range(-1, 1, length=100) | `np.linspace(-1, 1, 100)` |

**Rmk.**
- Julia's `range` allows floating-point steps while Python's `range` is exclusively integers.

Assuming `x = range(-5π, 5π, length=100)`,
| Julia | Julia Equiv. |
| ----- | ------ |
| @. sin(x) / x | sin.(x) ./ x |
