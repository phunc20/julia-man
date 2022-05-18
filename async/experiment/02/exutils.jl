using JSON
using ProgressBars
using BenchmarkTools

function write_json(path::String, n::Integer)
  dict = Dict(k => collect(1:k) for k in 1:n)
  data = JSON.json(dict)
  open(path, "w") do io
    write(io, data)
  end
end

function async_gen_data()
  folder = mktempdir()
  function producer(channel::Channel)
    for n in 1000:1050
      put!(channel, n)
    end
  end
  for n in Channel(producer)
    @async write_json("$folder/$n.json", n)
  end
end

function seq_gen_data()
  folder = mktempdir()
  for n in 1000:1050
    write_json("$folder/$n.json", n)
  end
end
