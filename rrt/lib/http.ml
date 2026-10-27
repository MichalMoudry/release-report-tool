(**
A module containing utilities around HTTP protocol.
@author Michal Moudrý
*)

module type Client =
  sig
    val get : string -> (string, string) result
  end

(*module type ClientSig =
  sig
    val get : string -> (string, string) result
  end*)

module MakeClient(Dep : Client) =
  struct
    let get = Dep.get
  end

module CurlyClient : Client =
  struct
    let get url =
      let result = Curly.(run (Request.make ~url ~meth:`GET ())) in
      match result with
      | Ok response -> Ok response.body
      | Error err -> match err with
        | Curly.Error.Invalid_request msg ->
          Error (Printf.sprintf "Invalid request: %s" msg)
        | _ -> Error "General request error"
  end
