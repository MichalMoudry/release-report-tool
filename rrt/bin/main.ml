let config_path = ref ""

let set_config_path value = match value with
| "" -> failwith "Missing config path"
| str -> config_path := str

(**A list of tool's arguments*)
let spec_list = [
  (
    "-c",
    Arg.String set_config_path,
    "Set a path to a configuration file need to run the tool"
  );
  (*("-o", Arg.Tuple [], "")*)
]

(** A function that will be called when the tool get anonymous arguments *)
let anon_func value = print_endline ("Received invalid input: " ^ value)

let generate_report cfg_path format =
  try
    let _ = Rrt.Config.get_config cfg_path |> Rrt.Config.print_config in
    Ok "Release report was generated successfully!"
  with e -> Error ("failed to generate the report: " ^ Printexc.to_string e)

let () =
  let usage_msg = "rrt -c <config> -o [Console|HTML]" in
  Arg.parse spec_list anon_func usage_msg;
  match generate_report !config_path "" with
  | Ok message -> print_endline message
  | Error message -> prerr_endline ("Error: " ^ message); exit 1
