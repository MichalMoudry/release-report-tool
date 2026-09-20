let anon_fun value = print_endline ("Received invalid input: " ^ value)

let config_path = ref "./config.json"

let spec_list =
  [
    (
      "-c",
      Arg.Set_string config_path,
      "Set a path to a configuration file need to run the tool"
    );
    (*("-o", Arg.Tuple [], "")*)
  ]

(** A structure containing tool's configuration data *)
type config = {
  url: string;
  access_token: string option
}

let read_file chan =
  let rec loop acc = match input_line chan with
  | line -> loop (line :: acc) in
  loop []

(**A function responsible for generating the release report*)
let generate_report cfg_path format =
  try
    let input_chan = open_in !cfg_path in
    let finally () = close_in input_chan in
    let read () = read_file input_chan in
    let config_content = Fun.protect ~finally read in
    let cfg = Yojson.Safe.from_string config_content in
    Format.printf "Parsed to %a" Yojson.Safe.pp cfg;
    Ok "Set a path to a configuration file need to run the tool"
  with e -> Error ("Failed to generate the report: " ^ Printexc.to_string e)

let () =
  let usage_msg = "rrt -c <config> -o [Console|HTML]" in
  Arg.parse spec_list anon_fun usage_msg;
  match generate_report config_path "" with
  | Ok message -> print_endline message
  | Error message -> print_endline ("Error: " ^ message); exit (1)
