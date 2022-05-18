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

function write_prime_json(path::String, n::Integer)
  dict = Dict(k => get_prime!(k) for k in 1:n)
  data = JSON.json(dict)
  open(path, "w") do io
    write(io, data)
  end
end

function async_gen_data()
  folder = mktempdir()
  function producer(channel::Channel)
    start = 1000
    step = start
    stop = 10_000
    for n in start:step:stop
      put!(channel, n)
    end
  end
  for n in Channel(producer)
    @async write_prime_json("$folder/$n.json", n)
  end
end

function seq_gen_data()
  folder = mktempdir()
  start = 1000
  step = start
  stop = 10_000
  for n in start:step:stop
    write_prime_json("$folder/$n.json", n)
  end
end
