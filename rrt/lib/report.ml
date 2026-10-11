type format = Console | Html

(**
Returns a release report format based on a provided string.
@raise Failure if the string is outside of a range of expected values.
*)
let get_format str = match str with
  | "Console" -> Console
  | "HTML" -> Html
  | _ -> failwith "Invalid format value"
