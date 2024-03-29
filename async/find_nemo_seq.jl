using Printf

using ArgParse
using BenchmarkTools
using JSON
using Glob

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
  end

  parsed_args = parse_args(ARGS, s)
  json_paths = expand(parsed_args["jsons"])
  #println("json_paths = ", json_paths)

  #@benchmark for path in json_paths
  #@elapsed for path in json_paths
  @time for path in json_paths
    json = read_json(path)
    if json["name"] == "Nemo"
      println("Found Nemo in ", path)
      break
    end
  end
end
