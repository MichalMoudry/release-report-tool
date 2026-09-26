type config = {
  url : string;
  access_token : string option;
  environment : string option;
  start_date : string;
  number_of_months : int
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
  {
    url = "";
    access_token = None;
    environment = Some "main";
    start_date = "";
    number_of_months = 12
  }

let print_config cfg =
  print_endline "== Configuration";
  print_endline ("🌐 URL: " ^ cfg.url);
  print_endline (
    "👋 Is access token set: "
    ^ (Option.is_some cfg.access_token |> string_of_bool)
  );
  cfg
