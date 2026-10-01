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

let read_file chan =
  let rec loop acc =
    match try Some (input_line chan) with End_of_file -> None with
    | Some line -> loop (line :: acc)
    | None -> [] in
  loop []

let generate_report config_path format =
  if config_path = "" then
    Error "No config path has been provided"
  else
    try
      (*let _ = Rrt.Config.get_config cfg_path |> Rrt.Config.pp_config in*)
      let chan = open_in config_path in
      let finally () = close_in chan in
      let read_config () = read_file chan in
      let config = Fun.protect ~finally read_config |> List.fold_left (^) "" in
      let cfg = Yojson.Safe.from_string config in
      Ok "Release report was generated successfully!"
    with e -> Error ("failed to generate the report: " ^ Printexc.to_string e)

let () =
  let usage_msg = "rrt -c <config> -f [Console|HTML]" in
  Arg.parse spec_list anon_func usage_msg;

  let format = Rrt.Report.get_format !format_argument in
  match generate_report !config_path format with
  | Ok message -> print_endline message
  | Error message -> prerr_endline ("Error: " ^ message); exit 1
