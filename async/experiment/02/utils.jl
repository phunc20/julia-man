using JSON
using ProgressBars
using BenchmarkTools

primes = [2,3]

function is_prime(n)
  @assert n isa Integer
  if n <= 1
    return false
  elseif n == 2
    return true
  elseif n % 2 == 0
    return false
  else
    for divisor in n-2:-2:round(Int, √n)
      if n % divisor == 0
        return false
      end
    end
    return true
  end
end

"""
Get the n-th prime number, the first prime number being 2.
"""
function get_prime!(n)
  #global primes
  if length(primes) < n
    k = primes[end] + 2
    while length(primes) < n
      #println("k = $k")
      #println("primes = $(primes)")
      #println("k is prime = $(is_prime(k))")
      #println("length(primes) = $(length(primes))")
      if is_prime(k)
        push!(primes, k)
      end
      k += 2
    end
  end
  return primes[n]
end

function write_simple_json(path::String, c::Char)
  dict = Dict(c => Int(c) - Int('a') + 1)
  data = JSON.json(dict)
  open(path, "w") do io
    write(io, data)
  end
end

function write_prime_json(path::String, c::Char)
  dict = Dict(c => Int(c) - Int('a') + 1)
  data = JSON.json(dict)
  open(path, "w") do io
    write(io, data)
  end
end

function bad_async_gen_data()
  folder = mktempdir()
  function producer(channel::Channel)
    for c in 'a':'z'
      put!(channel, c)
    end
  end
  for c in Channel(producer)
    @async write_simple_json("$folder/$c.json", c)
  end
end

function wrong_async_gen_data()
  folder = mktempdir()
  for c in 'a':'z'
    path = "$folder/$c.json"
    @async write_simple_json(path, c)
  end
end

function seq_gen_data()
  folder = mktempdir()
  for c in 'a':'z'
    path = "$folder/$c.json"
    if !isfile(path)
      dict = Dict(c => Int(c) - Int('a') + 1)
      data = JSON.json(dict)
      open(path, "w") do io
        write(io, data)
      end
    end
  end
end

function get_content(json_path)
  content = open(json_path, "r") do io
    raw_content = read(io, String)
    JSON.parse(raw_content)
  end
  return content
end

function seq_merge(json_paths)
end

function async_merge(json_paths)
end

