type sw = {
  start : Unix.tm;
  finish : Unix.tm option
}

(** A function that returns current local time. *)
let now () = Unix.localtime (Unix.time ())

(** A function for starting a new instance *)
let start_new = { start = now (); finish = None }

let stop stopwatch =
  let fin = Some (now ()) in
  { stopwatch with finish = fin }
