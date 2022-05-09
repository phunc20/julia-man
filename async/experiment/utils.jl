using JSON
using ProgressBars
using BenchmarkTools

function write_simple_json(path::String, c::Char)
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

