### A Pluto.jl notebook ###
# v0.16.1

using Markdown
using InteractiveUtils

# ╔═╡ 27fc10cc-33fb-11ec-1bee-458dc1b53cb7
t = ccall(:clock, Int32, ())

# ╔═╡ c06faa82-3015-4981-aa74-d748b8455a2b
typeof(t)

# ╔═╡ c292cb68-2dec-44fe-8c52-9d99fe192821
path = ccall(:getenv, Cstring, (Cstring,), "SHELL")

# ╔═╡ 3e12553f-68fc-43b8-ad27-7320706cd328
unsafe_string(path)

# ╔═╡ a13dab0a-6258-4fa1-8c16-979a8f3f091c
@doc unsafe_string

# ╔═╡ e94b4bf9-a529-4582-85ce-07b3708c254c
function getenv(var::AbstractString)
  val = ccall(:getenv, Cstring, (Cstring,), var)
  if val == C_NULL
    error("getenv: undefined variable: ", var)
  end
  return unsafe_string(val)
end

# ╔═╡ 5b253c0a-88c4-47ed-a718-5f7180a281ab
getenv("PATH")

# ╔═╡ 3ce24e62-3c53-4d6b-88c0-897664245332
getenv("FOOBAR")

# ╔═╡ ab36ccff-85c6-4a13-8507-b953d68c8f0e
function gethostname()
  hostname = Vector{UInt8}(undef, 256) # MAXHOSTNAMELEN
  #err = ccall((:gethostname, "libc"), Int32,
  err = ccall(:gethostname, Int32,
              (Ptr{UInt8}, Csize_t),
              hostname, sizeof(hostname))
  Base.systemerror("gethostname", err != 0)
  hostname[end] = 0 # ensure NUL-termination
  return GC.@preserve hostname unsafe_string(pointer(hostname))
end

# ╔═╡ 90a212b3-da9f-4255-90ab-f6d549f6140a
gethostname()

# ╔═╡ Cell order:
# ╠═27fc10cc-33fb-11ec-1bee-458dc1b53cb7
# ╠═c06faa82-3015-4981-aa74-d748b8455a2b
# ╠═c292cb68-2dec-44fe-8c52-9d99fe192821
# ╠═3e12553f-68fc-43b8-ad27-7320706cd328
# ╠═a13dab0a-6258-4fa1-8c16-979a8f3f091c
# ╠═e94b4bf9-a529-4582-85ce-07b3708c254c
# ╠═5b253c0a-88c4-47ed-a718-5f7180a281ab
# ╠═3ce24e62-3c53-4d6b-88c0-897664245332
# ╠═ab36ccff-85c6-4a13-8507-b953d68c8f0e
# ╠═90a212b3-da9f-4255-90ab-f6d549f6140a
