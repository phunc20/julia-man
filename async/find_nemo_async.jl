include("find_nemo_seq.jl")

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

  function producer(c::Channel)
    for path in json_paths
      put!(c, (path, read_json(path)))
    end
  end

  #@elapsed for (path, json) in Channel(producer)
  @time for (path, json) in Channel(producer)
    if json["name"] == "Nemo"
      println("Found Nemo in ", path)
      break
    end
  end
end
