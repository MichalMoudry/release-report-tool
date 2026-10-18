type format = Console | Html

let get_format str = match str with
  | "Console" -> Console
  | "HTML" -> Html
  | _ -> failwith "Invalid format value"

let create_err_message message =
  Printf.sprintf "failed to generate the report -> %s" message

let create config format = match format with
  | Console -> Ok ()
  | Html -> Error "Not yet implemented"
