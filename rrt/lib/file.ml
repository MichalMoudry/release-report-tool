(**
Reads all lines from an input channel.
@author Michal Moudrý
@param channel The input channel that should be read.
@returns A list of lines from the input channel.
*)
let read_all_lines channel =
  let rec loop acc =
    let line = try Some (input_line channel) with End_of_file -> None in
    match line with
    | Some str -> loop (str :: acc)
    | None -> acc in
  loop [] |> List.rev

(**
Function for reading contents of a file from a specified path.
@author Michal Moudrý
@param path A path to a file
@return A list of lines contained withing the specified file.
*)
let read path =
  let channel = open_in path in
  let finally () = close_in channel in
  let read () = read_all_lines channel in
  Fun.protect ~finally read
