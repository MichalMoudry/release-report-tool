type format = Console | Html

let get_format str = match str with
  | "Console" -> Console
  | "HTML" -> Html
  | _ -> failwith "Invalid format value"

let create (config: Rrt.Config.config) format fetch =
  match format with
  | Console ->
    let res = fetch config.url in
    if Result.is_error res then
      Error (Result.get_error res)
    else
      let api_response = Result.get_ok res in
      Ok (print_endline api_response)
  | Html -> Error "Not yet implemented"

let create_err_message message =
  Printf.sprintf "failed to generate the report -> %s" message
