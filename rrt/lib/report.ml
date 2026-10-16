open Lwt
open Cohttp
open Cohttp_lwt_unix

type format = Console | Html

(**
Returns a release report format based on a provided string.
@raise Failure if the string is outside of a range of expected values.
*)
let get_format str = match str with
  | "Console" -> Console
  | "HTML" -> Html
  | _ -> failwith "Invalid format value"

let fetch_data url resp_handler =
  Client.get (Uri.of_string url) >>= fun (resp, body) ->
    let _ = resp |> Response.status |> Code.code_of_status in
    body |> Cohttp_lwt.Body.to_string >|= resp_handler
