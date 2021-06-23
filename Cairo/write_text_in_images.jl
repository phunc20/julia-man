### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 8aed4714-d302-11eb-3fe2-112c060e0703
begin
  using Pkg
  Pkg.activate(Base.Filesystem.homedir() * "/.config/julia/projects/oft")
  using Plots
  using Images
  using Luxor
  using Cairo
  using FreeTypeAbstraction
  using Printf
  using JSON
  using PlutoUI
end

# ╔═╡ 34393f9c-087f-4868-9eae-d2e296ab9804
md"""
# Putting Texts in Images
In this notebook, we try to explore Julia's ways to put texts in images. In particular, we are interested in putting texts **in many languages** (e.g. Japanese, Vietnamese), instead of in English only.
"""

# ╔═╡ 0550d093-d922-4263-92f3-b7078e8223a6
begin
  image = load("tokyo.jpg")
  plot(image, background_color=:black)
  annotate!(1,1,Plots.text("母音は5種類しかないなど、", 20, color=:orange))
end

# ╔═╡ d64fe170-41b1-4bed-bb98-c093c2e887ad
"母音は5種類しかないなど、"

# ╔═╡ ee50d35b-10fc-4c58-9837-7ed50b505af5
md"""
This first method using `Plots.text` failed to display Japanese texts on images.
"""

# ╔═╡ fa13a487-c643-4c73-85a5-29867d3687ad
md"""
## `Luxor`

"""

# ╔═╡ a4efc477-3029-48d1-a3cb-ee797387134a
# begin
#   #plot(image, background_color=:black)
#   Drawing("tokyo.jpg")
#   pt1 = Point(10, 100)
#   Luxor.text("母音は5種類しかないなど、", pt1)
# end

# ╔═╡ fa48d179-a448-47ac-9e6b-de82e0b5401a
md"""
## `Cairo`
"""

# ╔═╡ 63e33891-af0a-415c-940a-b207ab68734d
typeof(image)

# ╔═╡ d852bbd2-4086-41a7-bc3d-71052a069b31
#c = CairoRGBSurface(256,256)
#c = CairoRGBSurface(image)
#c = CairoRGBSurface("tokyo.jpg")
#image

# ╔═╡ 0f2c0bee-f10b-4a24-988a-3645a8ddba6d
md"""
At least we need to check first whether `Cairo` is capable of displaying Japanese!
"""

# ╔═╡ 2a3fc475-1367-4c9e-b262-a8e5cc69ddd0
let
  c = CairoRGBSurface(256,256);
  cr = CairoContext(c);
  
  Cairo.save(cr);
  set_source_rgb(cr,0.8,0.8,0.8);    # light gray
  rectangle(cr,0.0,0.0,256.0,256.0); # background
  fill(cr);
  restore(cr);
  
  Cairo.save(cr);
  
  set_font_face(cr, "Sans 16")
  
  Cairo.text(cr,16.0,40.0,"Hamburgefons")
  Cairo.text(cr,16.0,72.0,"sp⁰¹²³,min⁻²,αΑβΒφϕΦγΓ")
  Cairo.text(cr,16.0,104.0,"Text<b>Bold</b><i>Italic</i><sup>super-2</sup>",markup=true)
  #Cairo.
  Cairo.text(cr,40.0,224.0,"母音は5種類し <span foreground=\"white\" background=\"blue\">aufwärts</span> !",markup=true,angle=30.0)
  
  #using textwidth and height
  
  set_font_face(cr, "Sans 12")
  
  a = "A"
  aheight = textheight(cr,a)
  awidth = textwidth(cr,a)
  atext = @sprintf("%s wd=%2.2f,ht=%2.2f",a,awidth,aheight)
  Cairo.text(cr,16.0,240.0,atext,markup=true)
  
  
  ## mark picture with current date
  restore(cr);
  move_to(cr,0.0,12.0);
  set_source_rgb(cr, 0,0,0);
  show_text(cr,Libc.strftime(time()));
  c
end

# ╔═╡ c2a86007-472f-48a8-bbf6-f2d706dbddc0
md"""
Great, `Cairo` can display Japanese.

Next up, we need to figure out how to load an image in `Cairo`.
It seems that `Cairo` can only read from PNG files. In case this is true, you may use the Linux program `imagemagick`'s command to convert btw diff image file formats.
```bash
convert tokyo.jpg tokyo.png
```
"""

# ╔═╡ da612d95-be76-4267-907a-9d67b2bb91f8
let
  image_Cairo = read_from_png("tokyo.png")
  # read_from_png cannot read jpg format
  #image_Cairo = read_from_png("tokyo.jpg")
  typeof(image_Cairo), image_Cairo
end

# ╔═╡ d00967a5-aed3-4f6d-bfe4-4238700d0fd4
res_JSON = JSON.parsefile("tokyo.json")

# ╔═╡ 8cc85a75-cfb0-40b5-bb2f-16f7212bf582
res_JSON.keys

# ╔═╡ 6908f528-f6fb-4750-9e4f-ac28bb7e4101
keys(res_JSON)

# ╔═╡ 103bdb2b-df94-4dd9-b93f-915177c43dd5
res_JSON["words"]

# ╔═╡ 0f8271d0-a095-41ec-a549-7cc9263c2700
res_JSON["words"][1]["boundingBox"]

# ╔═╡ 054ec70b-5ab9-46b9-8c5a-5b984313b4e9
function polygon(coordinates, cr)
  x1, y1 = coordinates[1]
  move_to(cr, x1, y1)
  for i in 2:length(coordinates)
    x, y = coordinates[i]
    line_to(cr, x, y);
    move_to(cr, x, y);
  end
  line_to(cr, x1, y1);
end

# ╔═╡ 0f204905-a409-44c7-b0de-e9de5573be5b
let
  with_terminal() do
    for D_detected in res_JSON["words"]
      println(D_detected["boundingBox"])
    end
  end
end

# ╔═╡ 676a6488-a6db-49f5-9927-369cd135be9b
let
  #image_Cairo = read_from_png("tokyo.png")
  #c = CairoRGBSurface(image_Cairo)
  #cr = CairoContext(image_Cairo)

  res_JSON = JSON.parsefile("tokyo.json")
  c = read_from_png("tokyo.png")
  cr = CairoContext(c)
  set_source_rgb(cr, 1, 0.5, 0);
  for D_detected in res_JSON["words"]
    polygon(D_detected["boundingBox"], cr)
  end
  set_line_width(cr, 7.1)
  Cairo.stroke(cr)
  c
end

# ╔═╡ dafdf846-14a9-4cff-acab-d61562384b2c
atan(1) * (180/π)

# ╔═╡ 42578bb1-2eba-40d6-856c-02b67127d01e
atan(√3, 1) * (180/π)

# ╔═╡ 27dc388b-683d-40f4-a4bc-af00daf8f91e
"""
    process
Note.
- angle=-angle because in computer vision, the y-axis is in the opposite direction to the y-axis in mathematics
"""
function process(D_detected, cr)
  set_font_face(cr, "Sans 16")
  x1, y1 = D_detected["boundingBox"][1]
  x2, y2 = D_detected["boundingBox"][2]
  angle = atan(y2-y1, x2-x1) * (180/π)
  txt = D_detected["text"]
  Cairo.text(cr,
             x1, y1,
             txt;
             halign="right",
             valign="bottom",
             markup=true,
             angle=-angle,
  )
  polygon(D_detected["boundingBox"], cr)
end

# ╔═╡ 92dcef04-8bab-4a35-bd99-baef7607809a
let
  res_JSON = JSON.parsefile("tokyo.json")
  c = read_from_png("tokyo.png")
  cr = CairoContext(c)
  color = (1, 0.5, 0)
  set_source_rgb(cr, color...);
  for D_detected in res_JSON["words"]
    process(D_detected, cr)
  end
  set_line_width(cr, 2.1)
  Cairo.stroke(cr)
  c
end

# ╔═╡ 3f860eeb-33f5-498c-bef9-c37d2d9c128d
md"""
## Ref
Here below are the references I consult during the process of making this notebook, in decreasing order of relation.
- Cairo
  - The original Cairo
    - <https://www.cairographics.org/>
  - Learn Cairo in Julia from examples
    - <https://github.com/JuliaGraphics/Cairo.jl/blob/master/samples/Samples.md>
    - Same examples but in C <https://www.cairographics.org/samples/>
  - In Python, one can use `cairo` as well.
    - <https://chadrick-kwag.net/converting-cv2-img-to-cairo-surface/>
    - <https://stackoverflow.com/questions/13455256/paint-decoded-jpeg-to-cairo-surface>
- `Luxor`
  - <https://juliagraphics.github.io/Luxor.jl/v1.0/index.html>
  - <https://juliagraphics.github.io/Luxor.jl/stable/>
  - <https://github.com/JuliaGraphics/Luxor.jl>
- `imagemagick`
  - <https://imagemagick.org/script/convert.php>
- `JSON`
  - <https://github.com/JuliaIO/JSON.jl>
- `UnicodePlots`
  - <https://github.com/Evizero/UnicodePlots.jl>
- Unicode input
  - <https://docs.julialang.org/en/v1/manual/unicode-input/>
- `ImageDraw`
  - <https://juliaimages.org/ImageDraw.jl/dev/>
  - <https://github.com/JuliaImages/ImageDraw.jl/issues/4>
- `FreeTypeAbstraction`
  - <https://github.com/JuliaGraphics/FreeTypeAbstraction.jl>
- `FreeType`
  - <https://github.com/JuliaGraphics/FreeType.jl>
- `ImageView`
  - <https://github.com/JuliaImages/ImageView.jl#annotation-api>
"""

# ╔═╡ Cell order:
# ╟─34393f9c-087f-4868-9eae-d2e296ab9804
# ╠═8aed4714-d302-11eb-3fe2-112c060e0703
# ╠═0550d093-d922-4263-92f3-b7078e8223a6
# ╠═d64fe170-41b1-4bed-bb98-c093c2e887ad
# ╟─ee50d35b-10fc-4c58-9837-7ed50b505af5
# ╟─fa13a487-c643-4c73-85a5-29867d3687ad
# ╠═a4efc477-3029-48d1-a3cb-ee797387134a
# ╟─fa48d179-a448-47ac-9e6b-de82e0b5401a
# ╠═63e33891-af0a-415c-940a-b207ab68734d
# ╠═d852bbd2-4086-41a7-bc3d-71052a069b31
# ╟─0f2c0bee-f10b-4a24-988a-3645a8ddba6d
# ╠═2a3fc475-1367-4c9e-b262-a8e5cc69ddd0
# ╟─c2a86007-472f-48a8-bbf6-f2d706dbddc0
# ╠═da612d95-be76-4267-907a-9d67b2bb91f8
# ╠═d00967a5-aed3-4f6d-bfe4-4238700d0fd4
# ╠═8cc85a75-cfb0-40b5-bb2f-16f7212bf582
# ╠═6908f528-f6fb-4750-9e4f-ac28bb7e4101
# ╠═103bdb2b-df94-4dd9-b93f-915177c43dd5
# ╠═0f8271d0-a095-41ec-a549-7cc9263c2700
# ╠═054ec70b-5ab9-46b9-8c5a-5b984313b4e9
# ╠═0f204905-a409-44c7-b0de-e9de5573be5b
# ╠═676a6488-a6db-49f5-9927-369cd135be9b
# ╠═dafdf846-14a9-4cff-acab-d61562384b2c
# ╠═42578bb1-2eba-40d6-856c-02b67127d01e
# ╠═27dc388b-683d-40f4-a4bc-af00daf8f91e
# ╠═92dcef04-8bab-4a35-bd99-baef7607809a
# ╟─3f860eeb-33f5-498c-bef9-c37d2d9c128d
