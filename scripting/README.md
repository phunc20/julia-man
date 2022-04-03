
## Equiv. of Python's `if __name__ == "__main__":`
```julia
if abspath(PROGRAM_FILE) == @__FILE__
  nothing
end
```

I have created an example demonstrating this:

- `./test_main.jl` is a file containing code with and without `abspath(PROGRAM_FILE) == @__FILE__`
- `./importer.jl` is a file which `include`s `test_main.jl`

```bash
~/.../phunc20/julia-man/scripting $ julia test_main.jl
This runs when one `import` or `using` or `include` this script:
@__FILE__             = /home/phunc20/git-repos/phunc20/julia-man/scripting/test_main.jl
abspath(PROGRAM_FILE) = /home/phunc20/git-repos/phunc20/julia-man/scripting/test_main.jl

This runs when one runs this script as main script
@__FILE__             = /home/phunc20/git-repos/phunc20/julia-man/scripting/test_main.jl
abspath(PROGRAM_FILE) = /home/phunc20/git-repos/phunc20/julia-man/scripting/test_main.jl

~/.../phunc20/julia-man/scripting $ julia importer.jl
This runs when one `import` or `using` or `include` this script:
@__FILE__             = /home/phunc20/git-repos/phunc20/julia-man/scripting/test_main.jl
abspath(PROGRAM_FILE) = /home/phunc20/git-repos/phunc20/julia-man/scripting/importer.jl

~/.../phunc20/julia-man/scripting $
```


