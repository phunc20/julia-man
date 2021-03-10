### `Pkg`'s REPL
`Pkg` comes with its own REPL.
- To enter `Pkg`'s REPL from Julia's REPL, press **`]`**
- To exit `Pkg`'s REPL (and thus get back to Julia's REPL), press **backspace** or **`^C`**

```
# Some commands on Pkg's REPL:
# To add package(s)
add <package_name1> [<package_name2> <package_name3> ...]
# e.g.
(@v1.5) pkg> add JSON StaticArrays

# To remove package(s)
rm <package_name>
# e.g.
(@v1.5) pkg> rm JSON StaticArrays

# To add an unregistered package, specify a URL
# e.g.
(@v1.5) pkg> add https://github.com/JuliaLang/Example.jl
# To remove it, just specify its name
(@v1.5) pkg> rm Example

# To update some package, e.g.
(@v1.5) pkg> update Example
# To update all packages, just omit the arguments
(@v1.5) pkg> update

# Environment
(@v1.5) pkg> activate tuto
 Activating new environment at `~/tuto/Project.toml`

(tuto) pkg>
```


### Julia's equivalent to Python's virtual environment
```julia
path_tmp = mktempdir()
begin
  using Pkg
  Pkg.activate(path_tmp)
  Pkg.add([
    "Flux",
    "Plot"
  ])
end
```

**Note.** Notice that it's `mktempdir()` and not `mktemp()` -- The former returns a `String` containing the path to
the newly created temporary directory (usually a subdir in `/tmp/` in typical Linux OS) whereas the latter
returns a `Tuple` of `(String, IOStream)` in which the first `String` contains the path to the newly created
**file**.
```julia
julia> mktemp()
("/tmp/jl_A8vZU6", IOStream(<fd 20>))

julia> mktempdir()
"/tmp/jl_S6pmXy"

julia>
```




