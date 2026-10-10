type stopwatch = {
  start : Unix.tm;
  mutable finish : Unix.tm option;
  mutable elapsed : float
}

let unix_tm_to_iso_string (time : Unix.tm) =
  Format.sprintf "%04i-%02i-%02iT%02i-%02i-%02iZ"
  (time.tm_year + 1900)
  (time.tm_mon + 1)
  time.tm_mday
  time.tm_hour
  time.tm_min
  time.tm_sec

(** A function that returns current time with UTC timezone. *)
let now () = Unix.gmtime (Unix.time ())

let calculate_timestamp_diff start finish =
  let begining = fst (Unix.mktime start) in
  let close = fst (Unix.mktime finish) in
  close -. begining

let start_new () = { start = now (); finish = None; elapsed = 0. }

let stop sw =
  let timestamp = now () in
  let elapsed = calculate_timestamp_diff sw.start timestamp in
  sw.finish <- Some timestamp; sw.elapsed <- elapsed;
  elapsed
