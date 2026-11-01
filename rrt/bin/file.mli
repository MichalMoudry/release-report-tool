(**
A module that contains functions for dealing with all things related files.
@author Michal Moudrý
*)

(**
Function for reading contents of a file from a specified path.
@param path A path to a file
@return A list of lines contained withing the specified file.
@author Michal Moudrý
*)
val read : string -> string list
