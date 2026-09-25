(** A structure containing tool's configuration data *)
type config = {
  url: string;
  access_token: string option
}

let read_file chan =
  let rec loop list = match input_line chan with
  | line -> loop (line :: list) in
  try
    loop []
  with End_of_file -> []

(** Retrieves configuration information from a file *)
let get_config path =
  let input_chan = open_in path in
  let finally () = close_in input_chan in
  let read_config_file () = Yojson.Safe.from_channel input_chan in
  let content () = Fun.protect ~finally read_config_file in
  Format.printf "Parsed to %a" Yojson.Safe.pp (content ());
  { url = ""; access_token = None }

let print_config cfg =
  print_endline "== Configuration";
  print_endline ("🌐 URL: " ^ cfg.url);
  print_endline ("👋 Is access token set:");
  cfg
