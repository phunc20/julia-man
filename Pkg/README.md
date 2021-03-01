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

