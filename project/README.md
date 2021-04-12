The concept of **_project_** in Julia corresponds to **_virtual environment_** in Python.

A project is just a directory whose structure looks like
```
my_project/
    Project.toml
    Manifest.toml
```
The files `Project.toml` and `Manifest.toml` contain informations of the installed packages' versions, etc.

Julia has its default active project located in `~/.julia/environments/v#.#` (where `#.#` is the user's Julia
version, e.g. `1.5`). One can set a different project when starting Julia by
```bash
# BASH
Julia --project=/path/to/my_project
```
or by
```bash
# BASH
export JULIA_PROJECT=/path/to/my_project
Julia
```
or even after having started Julia by
```julia
# Julia
Pkg.activate("my_project")
# This will create a subdir named my_project in pwd if `my_project` does not already exist
# Analog in Python: virtualenv's `source my_project/en/bin/activate`
```





