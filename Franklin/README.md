# Franklin
Franklin is a static site generator written in Julia.
There exist other static site generators written in other languages.
To name a few: Hugo (Go), Jekyll (Ruby), Pelican (Python), Zola (Rust).

## Quick Start
```julia
julia> using Franklin
julia> newsite("mySite", template="pure-sm")
✓ Website folder generated at "mySite" (now the current directory).
→ Use serve() from Franklin to see the website in your browser.

julia> serve()
→ Initial full pass...
→ Starting the server...
✓ LiveServer listening on http://localhost:8000/ ...
  (use CTRL+C to shut down)
```

- The `"sm"` in `"pure-sm"` means **"side-menu"**, i.e. it will put a menu on one side, which at the time of writing is the left hand side.
- There are many other templates, e.g. `template="vela"`, etc. Cf. <https://tlienart.github.io/FranklinTemplates.jl/> for more info.

## Add New Webpages: `.md` and `.html` Files
It is simple to add a new webpage. Say, you want to add a `maths/` folder in the top directory to put all your articles on maths. Then you just need to
```bash
mkdir maths
vim maths/hessian.md
```

The file can be accessed through `http://localhost:8000/maths/hessian/` because the MarkDown file `hessian.md` has been transformed into `__site/maths/hessian/index.html`.

Not only are MarkDown files allowed, one can also add HTML files directly.
It is basically the same procedure. Say, you want to add a file named `norm.jl.html`,
that you tranformed from a Pluto notebook, under `maths/`
```bash
$ ls maths/
hessian.md  norm.jl.html
```

Once you put the file there, find the webpage through the following URL:<br>
`http://localhost:8000/maths/norm.jl/`

You see, it's the same logic: The file `norm.jl.html` has been transformed by Franklin
to `__site/maths/norm.jl/index.html`

## Tags
Say, in a MarkDown file, you specified
```
@def tags = ["maths", "education"]
```

Then

- `http://localhost:8000/tag/` gives 404
- `http://localhost:8000/tag/maths` gives a page of links to all pages tagged `"maths"`

