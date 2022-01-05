## Specify A Python Virtual Environment for `PyCall`
If you are a Python user, you probably have many virtual environment on your machine. But by default
Julia won't know which one you want to use, and it will use its a Python executable dependning on the
OS one uses

- Windows and MacOS: A separate Miniconda env exclusively for Julia
- Linux: The system's Python (e.g. `/usr/bin/python3` for Debian)

However, you are able to tell Julia which exact virtual environment you want to use. For example,
if you are already a Conda user in Python, and that you have already a few env at hand, then

```julia
using Pkg
# Change the next line to suit your own virtual env path, here mine is named `oft`
ENV["PYTHON"] = "/home/phunc20/.local/bin/miniconda3/envs/oft/bin/python"
Pkg.build("PyCall")
using PyCall
# You are good to go!
```

Caveats

- It seems that every time you install a new package in your Conda virtual env, you have to repeat the above `Pkg.build("PyCall")` with that env again; otherwise, you won't be able to import the new package.
- `virtualenvwrapper` seems to not cooperate with Julia as well as Conda. (Note that one can use `Sys.which("python")` or `Sys.which("python")` to check the Python
executable's path from inside Julia.)
  ```bash
  ~$ workon py3.7
  (py3.7) ~$ julia
                 _
     _       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
     _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.5.3 (2020-11-09)
   _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
  |__/                   |
  
  julia> Sys.which("python3")
  "/usr/bin/python3.7"
  
  julia> exit()
  (py3.7) ~$ deactivate
  ~$ source ~/.virtualenvs/py3.7/bin/activate  # this won't help, either
  (py3.7) ~$ julia
                 _
     _       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
     _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.5.3 (2020-11-09)
   _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
  |__/                   |
  
  julia> Sys.which("python3")
  "/usr/bin/python3.7"
  
  julia> Sys.which("python")
  "/usr/bin/python3.7"
  
  julia> exit()
  (py3.7) ~$ deactivate
  ~$ condact py3.10
  (py3.10) ~$ julia
                 _
     _       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
     _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.5.3 (2020-11-09)
   _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
  |__/                   |
  
  julia> Sys.which("python3")
  "/home/phunc20/.local/bin/miniconda3/envs/py3.10/bin/python3.10"
  
  julia> exit()
  (py3.10) ~$
  ```
- Even though you successfully built with `Pkg.build("PyCall")` with your favorite Conda env, the next time you use Julia REPL, `Sys.which("python3")` will still show system's Python, unless you activate your env before entering Julia REPL. Nevertheless, the Python with which you `using PyCall` will still remain your built Conda env's Python.

## Troubleshoot
### Failures
The cell with a single line of code `using PyCall` in ageron's IJulia notebook `Julia_for_Pythonistas.ipynb` on my
Thinkpad X220 suffered a period of time from always resulting in a dead kernel after executing.

It turned out that if we had used Julia REPL, there would have been more error messages:
```julia
julia> using PyCall
Python path configuration:
  PYTHONHOME = '/usr/local:/usr/local'
  PYTHONPATH = (not set)
  program name = '/home/phunc20/.virtualenvs/tf2.3.0-torch1.6.0-py3.7/bin/python'
  isolated = 0
  environment = 1
  user site = 1
  import site = 1
  sys._base_executable = '/home/phunc20/.virtualenvs/tf2.3.0-torch1.6.0-py3.7/bin/python'
  sys.base_prefix = '/usr/local'
  sys.base_exec_prefix = '/usr/local'
  sys.platlibdir = 'lib'
  sys.executable = '/home/phunc20/.virtualenvs/tf2.3.0-torch1.6.0-py3.7/bin/python'
  sys.prefix = '/usr/local'
  sys.exec_prefix = '/usr/local'
  sys.path = [
    '/usr/local/lib/python39.zip',
    '/usr/local/lib/python3.9',
    '/usr/local/lib/python3.9/lib-dynload',
  ]
Fatal Python error: init_fs_encoding: failed to get the Python codec of the filesystem encoding
Python runtime state: core initialized
ModuleNotFoundError: No module named 'encodings'

Current thread 0x00007f4af38bb240 (most recent call first):
<no Python frame>
```
This error message shows up no matter
- I used the default project (`~/.julia/environments/v1.5/`)
- or I created a new project (using `pkg"activate"`)

I have also fruitlessly tried to run Julia as
- `PYTHONHOME=$(which python3.7) julia`
- `unset PYTHONHOME; julia`
But none of these succeeded.

### One solution
It turned out that
- activating a new project
- **`build PyCall`** after `pkg"add PyCall"` is one solution.
  ```julia
  [phunc20@homography-x220t julia_notebooks]$ julia
                 _
     _       _ _(_)_     |  Documentation: https://docs.julialang.org
    (_)     | (_) (_)    |
     _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
    | | | | | | |/ _` |  |
    | | |_| | | | (_| |  |  Version 1.5.2 (2020-09-23)
   _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
  |__/                   |
  
  (@v1.5) pkg> activate projects/pythonista
   Activating new environment at `~/git-repos/phunc20/julia_notebooks/projects/pythonista/Project.toml`
  
  (pythonista) pkg> build PyCall
  ERROR: The following package names could not be resolved:
   * PyCall (not found in project or manifest)
  
  
  (pythonista) pkg> add PyCall
     Updating registry at `~/.julia/registries/General`
    Resolving package versions...
  Updating `~/git-repos/phunc20/julia_notebooks/projects/pythonista/Project.toml`
    [438e738f] + PyCall v1.92.3
  Updating `~/git-repos/phunc20/julia_notebooks/projects/pythonista/Manifest.toml`
    [8f4d0f93] + Conda v1.5.1
    [682c06a0] + JSON v0.21.1
    [1914dd2f] + MacroTools v0.5.6
    [69de0a69] + Parsers v1.1.0
    [438e738f] + PyCall v1.92.3
    [81def892] + VersionParsing v1.2.0
    [2a0f44e3] + Base64
    [ade2ca70] + Dates
    [8f399da3] + Libdl
    [37e2e46d] + LinearAlgebra
    [d6f4376e] + Markdown
    [a63ad114] + Mmap
    [de0858da] + Printf
    [9a3f8284] + Random
    [9e88b42a] + Serialization
    [4ec0a83e] + Unicode
  
  (pythonista) pkg> build PyCall
     Building Conda ─→ `~/.julia/packages/Conda/tJJuN/deps/build.log`
     Building PyCall → `~/.julia/packages/PyCall/BD546/deps/build.log`
  
  julia> using PyCall
  [ Info: Precompiling PyCall [438e738f-606a-5dbb-bf0a-cddfbfd45ab0]
  
  julia> py"print(f'1+2 = {1+2}')"
  1+2 = 3
  
  julia>
  ```
- Even the default project's `PyCall` can be corrected by the command `build PyCall`. It seems that this `build`
command corrects the wrong paths shown in the error message above. Let's verify this (by following [this README file](https://github.com/JuliaPy/PyCall.jl))
  - In `PyCall` there are a few attributes that we can check
    ```julia
    (pythonista) pkg>
    
    julia> PyCall.pyprogramname
    "/home/phunc20/.julia/conda/3/bin/python"
    
    julia> PyCall.PYTHONHOME
    "/home/phunc20/.julia/conda/3:/home/phunc20/.julia/conda/3"

    julia> PyCall.conda
    true
    ```

### Another solution
As far as I understand, the above solution using `build PyCall` is **to require Linux to install a separate conda directory (usually under `~/.julia/conda/3/`)**, whose Python will be used in `PyCall`. Instead of this, we have
another option, which is to use the Linux system's
default Python (i.e. the one when you call `which python` in terminal.)<br>
**Rmk**.
01. I don't know why, but only the system's default Python works -- Neither any additional Python versions
I installed under `usr/local/bin/python3.x` or virtualenv's Python have worked yet.
02. This solution has a drawback on rolling-release Linux distro (e.g. Arch-linux). Indeed, the system's default
Python version may change with time, leading to an unstable `PyCall`.
```bash
julia> ENV["PYTHON"] = Sys.which("python3.7")
"/usr/local/bin/python3.7"

julia> using Pkg; pkg"build PyCall"
Building Conda ─→ `~/.julia/packages/Conda/x5ml4/deps/build.log`
Building PyCall → `~/.julia/packages/PyCall/BD546/deps/build.log`

julia> using PyCall
[ Info: Precompiling PyCall [438e738f-606a-5dbb-bf0a-cddfbfd45ab0]
Python path configuration:
PYTHONHOME = '/usr/local:/usr/local'
PYTHONPATH = (not set)
program name = '/usr/local/bin/python3.7'
isolated = 0
environment = 1
user site = 1
import site = 1
sys._base_executable = '/usr/local/bin/python3.7'
sys.base_prefix = '/usr/local'
sys.base_exec_prefix = '/usr/local'
sys.platlibdir = 'lib'
sys.executable = '/usr/local/bin/python3.7'
sys.prefix = '/usr/local'
sys.exec_prefix = '/usr/local'
sys.path = [
'/usr/local/lib/python39.zip',
'/usr/local/lib/python3.9',
'/usr/local/lib/python3.9/lib-dynload',
]
Fatal Python error: init_fs_encoding: failed to get the Python codec of the filesystem encoding
Python runtime state: core initialized
ModuleNotFoundError: No module named 'encodings'

Current thread 0x00007f06cae2b240 (most recent call first):
<no Python frame>
~/git-repos/phunc20/julia_notebooks *** julia

   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.5.3 (2020-11-09)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> ENV["PYTHON"] = Sys.which("python")
"/usr/bin/python3.9"

(@v1.5) pkg> build PyCall
Building Conda ─→ `~/.julia/packages/Conda/x5ml4/deps/build.log`
Building PyCall → `~/.julia/packages/PyCall/BD546/deps/build.log`

julia> using PyCall
[ Info: Precompiling PyCall [438e738f-606a-5dbb-bf0a-cddfbfd45ab0]

julia> py"print(f'1 + 2 = {1+2}')"
1 + 2 = 3

julia> PyCall.conda
false
```

