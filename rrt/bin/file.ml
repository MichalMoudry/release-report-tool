(**
Reads all lines from an input channel.
@param channel The input channel that should be read.
@returns A list of lines from the input channel.
@author Michal Moudrý
*)
let read_all_lines channel =
  let rec loop lst = match input_line channel with
  | exception End_of_file -> lst
  | line -> loop (line :: lst) in
  loop [] |> List.rev

let read path =
  let channel = open_in path in
  let finally () = close_in channel in
  let read () = read_all_lines channel in
  Fun.protect ~finally read
