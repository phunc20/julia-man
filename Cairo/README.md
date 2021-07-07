



## How to Save A `Cairo.Surface`?
There is a method named **`write_to_png`** which can be used for
saving purposes.

**Note.** It seems that such saves when read using `Image.load` will
display blurry images (at least on Pluto). A workaround is to display
the saved PNG files using `Cairo.read_from_png` instead.








