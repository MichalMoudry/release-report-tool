(**
A module containing utilities around HTTP protocol.
@author Michal Moudrý.
*)

type supported_method = GET | POST

module type Client = sig
  type ok
  type err
  val get : string -> supported_method -> (ok, err) result
end

let get url =
  let req = Curly.(Request.make ~url ~meth:`GET ()) in
  let temp = Curly.(run req) in
  match Curly.(run (Request.make ~url ~meth:`GET ())) with
  | Ok response -> Ok response.body
  | Error err -> match err with
    | Curly.Error.Invalid_request msg -> Error (Printf.sprintf "Invalid request: %s" msg)
    | _ -> Error "General request error"

(*module type Client = sig
  val get : string -> (string, string) result
end

module CurlyClient = struct
  let get url =
    match Curly.(run (Request.make ~url ~meth:`GET ())) with
    | Ok response -> Ok response.body
    | Error err -> match err with
      | Curly.Error.Invalid_request msg -> Error (Printf.sprintf "Invalid request: %s" msg)
      | _ -> Error "General request error"
end

let get (module C : Client) url = C.get url*)
