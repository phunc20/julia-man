## REPL
To run a Julia REPL with multiple threads, just specify as below.
```bash
[phunc20@homography-x220t ~]$ JULIA_NUM_THREADS=4 julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.5.2 (2020-09-23)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> using Base.Threads

julia> nthreads()
4

julia> ENV["JULIA_NUM_THREADS"]
"4"
```


## IJulia
To run an IJulia/Jupyter notebook kernel with multiple threads, cf. This repo `IJulia/README.md`.


## Pluto
To run Pluto with multiple threads, I guess it's the same as for Julia REPL:
- Run the command `JULIA_NUM_THREADS=4 julia`
- `using Pluto`
- `Pluto.run()`
