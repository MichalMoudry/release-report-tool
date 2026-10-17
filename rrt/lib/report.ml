open Lwt
open Cohttp
open Cohttp_lwt_unix

type format = Console | Html

let get_format str = match str with
  | "Console" -> Console
  | "HTML" -> Html
  | _ -> failwith "Invalid format value"

let create_err_message message =
  Printf.sprintf "failed to generate the report -> %s" message

let fetch_data url resp_handler =
  Client.get (Uri.of_string url) >>= fun (resp, body) ->
    let _ = resp |> Response.status |> Code.code_of_status in
    body |> Cohttp_lwt.Body.to_string >|= resp_handler

let create config format = match format with
  | Console -> Ok ()
  | Html -> Error "Not yet implemented"
