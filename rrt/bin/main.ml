(** A path to a config file *)
let config_path = ref ""
let format_argument = ref ""

(** A list of tool's arguments *)
let spec_list = [
  (
    "-c",
    Arg.Set_string config_path,
    "Sets a path to a configuration file need to run the tool"
  );
  (
    "-f",
    Arg.Set_string format_argument,
    "Sets a type of a format that the release report should be in"
  )
]

(** A function that will be called when the tool get anonymous arguments *)
let anon_func value = print_endline ("Received invalid input: " ^ value)

(**
A function for generating a release report based on a provided configuration
and a format.
*)
let generate_report config_path format =
  if config_path = "" then
    Error "No config path has been provided"
  else
    try
      let sw = Rrt.Stopwatch.start_new () in
      let config =
        Rrt.File.read config_path
        |> List.fold_left (^) ""
        |> Rrt.Config.get_config in
      Rrt.Config.pp_config config;
      let elapsed = Rrt.Stopwatch.stop sw in
      Ok (Format.sprintf "Release report was generated successfully! Took: %fs" elapsed)
    with e -> Error ("failed to generate the report -> " ^ Printexc.to_string e)

let () =
  let usage_msg = "rrt -c <config> -f [Console|HTML]" in
  Arg.parse spec_list anon_func usage_msg;

  let format = Rrt.Report.get_format !format_argument in
  match generate_report !config_path format with
  | Ok message -> print_endline message
  | Error message -> prerr_endline ("Error: " ^ message); exit 1
