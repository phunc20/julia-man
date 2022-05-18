using JSON
using ProgressBars
using BenchmarkTools


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
function get_prime(n)
  primes = [2,3]
  if length(primes) < n
    k = primes[end] + 2
    while length(primes) < n
      if is_prime(k)
        push!(primes, k)
      end
      k += 2
    end
  end
  return primes[n]
end

function write_prime_json(path::String, n::Integer)
  dict = Dict(n => get_prime(n))
  data = JSON.json(dict)
  open(path, "w") do io
    write(io, data)
  end
end

function async_gen_data()
  folder = mktempdir()
  function producer(channel::Channel)
    for n in range(500, 1000, step=250)
      put!(channel, n)
    end
  end
  for n in Channel(producer)
    @async write_prime_json("$folder/$n.json", n)
  end
end

function seq_gen_data()
  folder = mktempdir()
  for n in range(500, 1000, step=250)
    write_prime_json("$folder/$n.json", n)
  end
end
