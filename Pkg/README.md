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


## Equiv. to Python's `pip` or `conda`
|Julia (in interactive mode) | Python (in a terminal)
|-----|------
|`]status` | `pip freeze`<br />or<br />`conda list`
|`]add Foo` | `pip install foo`<br />or<br />`conda install foo`
|`]add Foo@1.2` | `pip install foo==1.2`<br />or<br />`conda install foo=1.2`
|`]update Foo` | `pip install --upgrade foo`<br />or<br />`conda update foo`
|`]pin Foo` | `foo==<version>` in `requirements.txt`<br /> or<br />`foo=<version>` in `environment.yml`
|`]free Foo` | `foo` in `requirements.txt`<br />or<br />`foo` in `environment.yml`
|`]test Foo` | `python -m unittest foo`
|`]rm Foo` | `pip uninstall foo`<br />or<br />`conda remove foo`
|`]help` | `pip --help`


- **`]st`** (or `]status`)
  ```julia
  (youtube) [phunc20@homography-x220t one_punch_man]$ julia -e "using Pkg; pkg\"st\""
  Status `~/.julia/environments/v1.5/Project.toml`
    [6e4b80f9] BenchmarkTools v0.5.0
    [336ed68f] CSV v0.7.7
    [35d6a980] ColorSchemes v3.10.1
    [5ae59095] Colors v0.12.4
    [a93c6f00] DataFrames v0.21.8
    [31a5f54b] Debugger v0.6.6
    [cc61a311] FLoops v0.1.6
    [f6369f11] ForwardDiff v0.10.16
    [7073ff75] IJulia v1.22.0
    [82e4d734] ImageIO v0.3.0
    [6218d12a] ImageMagick v1.1.6
    [916415d5] Images v0.22.4
    [2fda8390] LsqFit v0.11.0
    [91a5bcdd] Plots v1.8.0
    [c3e4b0f8] Pluto v0.12.21
    [7f904dfe] PlutoUI v0.6.10
    [438e738f] PyCall v1.92.1
    [d330b81b] PyPlot v2.9.0
    [8e980c4a] Shapefile v0.6.2
    [90137ffa] StaticArrays v0.12.5
    [2913bbd2] StatsBase v0.33.3
    [fd094767] Suppressor v0.2.0
    [24249f21] SymPy v1.0.32
    [a5390f91] ZipFile v0.9.3
    [b77e0a4c] InteractiveUtils
  (youtube) [phunc20@homography-x220t one_punch_man]$ pip freeze
  youtube-dl==2021.3.31
  (youtube) [phunc20@homography-x220t one_punch_man]$ conda list
  # packages in environment at /home/phunc20/.config/miniconda3:
  #
  # Name                    Version                   Build  Channel
  _libgcc_mutex             0.1                        main  
  ca-certificates           2020.10.14                    0  
  certifi                   2020.11.8        py38h06a4308_0  
  cffi                      1.14.0           py38he30daa8_1  
  chardet                   3.0.4                 py38_1003  
  conda                     4.9.2            py38h06a4308_0  
  conda-package-handling    1.6.1            py38h7b6447c_0  
  cryptography              2.9.2            py38h1ba5d50_0  
  idna                      2.9                        py_1  
  imutils                   0.5.3                    pypi_0    pypi
  ld_impl_linux-64          2.33.1               h53a641e_7  
  libedit                   3.1.20181209         hc058e9b_0  
  libffi                    3.3                  he6710b0_1  
  libgcc-ng                 9.1.0                hdf63c60_0  
  libstdcxx-ng              9.1.0                hdf63c60_0  
  ncurses                   6.2                  he6710b0_1  
  numpy                     1.19.4                   pypi_0    pypi
  opencv-contrib-python     4.4.0.46                 pypi_0    pypi
  openssl                   1.1.1h               h7b6447c_0  
  pip                       20.2.4           py38h06a4308_0  
  pycosat                   0.6.3            py38h7b6447c_1  
  pycparser                 2.20                       py_0  
  pyopenssl                 19.1.0                   py38_0  
  pysocks                   1.7.1                    py38_0  
  python                    3.8.3                hcff3b4d_0  
  readline                  8.0                  h7b6447c_0  
  requests                  2.23.0                   py38_0  
  ruamel_yaml               0.15.87          py38h7b6447c_0  
  setuptools                46.4.0                   py38_0  
  six                       1.14.0                   py38_0  
  sqlite                    3.31.1               h62c20be_1  
  tk                        8.6.8                hbc83047_0  
  tqdm                      4.46.0                     py_0  
  urllib3                   1.25.8                   py38_0  
  wheel                     0.34.2                   py38_0  
  xz                        5.2.5                h7b6447c_0  
  yaml                      0.1.7                had09818_2  
  zlib                      1.2.11               h7b6447c_3  
  (youtube) [phunc20@homography-x220t one_punch_man]$
  ```


