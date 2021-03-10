## Inline math or displayed equation
- [https://juliadocs.github.io/Documenter.jl/v0.9/man/latex.html](https://juliadocs.github.io/Documenter.jl/v0.9/man/latex.html)

Briefly speaking, in Jupyter notebooks
- inline math is done by, for example, `$c^2 = a^2 + b^2$`, i.e. surrounding $\LaTeX$ code by single-dollar signs.
- displayed math is done by, for example, `$$c^2 = a^2 + b^2$$`, i.e. surrounding $\LaTeX$ code by double-dollar signs.

In Pluto notebooks, things are slightly different
- inline math is the same as above.
  - Besides, surrounding by **double-apostrophe signs** (aka **_double backtics_**) works as well, e.g. **``c^2 = a^2 + b^2``**
- displayed math is done however by, `\n$$c^2 = a^2 + b^2$$`, i.e. surrounding $\LaTeX$ code by double-dollar signs, **plus a newline** before the opening double-dollar sign.


