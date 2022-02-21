using ArgParse
using Glob
using JSON

function expand(path::String)
  dname = dirname(path)
  fname = basename(path)
  glob(fname, dname)
end

function expand(paths::Vector{Any})
  ans = []
  for path in paths
    append!(ans, expand(path))
  end
  ans
end

function read_json(path)
  json = open(path, "r") do io
    content = read(io, String)
    JSON.parse(content)
  end
  json
end


if abspath(PROGRAM_FILE) == @__FILE__
  s = ArgParseSettings()
  @add_arg_table s begin
    "jsons"
      nargs = '+'
      help = "path to json file(s)"
      required = true
    "--indent"
      help = "indentation for saved JSON file(s)"
      arg_type = Int
      default = 0
  end

  parsed_args = parse_args(ARGS, s)
  json_paths = expand(parsed_args["jsons"])
  for path in json_paths
    json = read_json(path)
    stem = splitext(basename(path))[1]
    indentation = parsed_args["indent"]
    data = if  indentation > 0
      JSON.json(json, indentation)
    else
      JSON.json(json)
    end
    open("$(stem)_lisible.json", "w") do f
      write(f, data)
    end
  end
end
