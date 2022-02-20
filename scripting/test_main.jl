
println("This runs when one `import` or `using` or `include` this script:")
println("@__FILE__             = $(@__FILE__)")
println("abspath(PROGRAM_FILE) = $(abspath(PROGRAM_FILE))\n")

if abspath(PROGRAM_FILE) == @__FILE__
  println("This runs when one runs this script as main script")
  println("@__FILE__             = $(@__FILE__)")
  println("abspath(PROGRAM_FILE) = $(abspath(PROGRAM_FILE))\n")
end

