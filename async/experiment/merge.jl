using JSON
using ProgressBars

function write_simple_json(c::Char, path::String)
  dict = Dict(c => Int(c) - Int('a') + 1)
  data = JSON.json(dict)
  open(path, "w") do io
    write(io, data)
  end
end

function async_gen_data()
  if !isdir("data")
    folder = mkdir("data")
  else
    folder = "data"
  end
  for c in 'a':'z'
    path = "$folder/$c.json"
    if !isfile(path)
      @async write_simple_json(c, path)
    end
  end
end

function seq_gen_data()
  if !isdir("data")
    folder = mkdir("data")
  end
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

#seq_gen_data()
async_gen_data()
