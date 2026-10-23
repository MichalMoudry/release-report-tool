type format = Console | Html

let get_format str = match str with
  | "Console" -> Console
  | "HTML" -> Html
  | _ -> failwith "Invalid format value"

let create_err_message message =
  Printf.sprintf "failed to generate the report -> %s" message

let test_request () =
  let client = (module Rrt.Http.CurlyClient : Rrt.Http.Client) in
  let res = Rrt.Http.get client "https://jsonplaceholder.typicode.com/posts/1" in
  match res with
  | Ok _ -> print_endline "Success"
  | Error err -> print_endline ("Request error: " ^ err)

let create config format = match format with
  | Console -> test_request (); Ok ()
  | Html -> Error "Not yet implemented"
