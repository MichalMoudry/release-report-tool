(**
A module containing types and functions related to creation of the release
report.
@author Michal Moudrý
*)

type format = Console | Html

(**
Returns a release report format based on a provided string.
@raise Failure if the string is outside of a range of expected values.
*)
val get_format : string -> format

(**
A function for creating an error message related to a creation of the release report.
@param message A piece of text that should be a part of the message.
@author Michal Moudrý
*)
val create_err_message : string -> string

val create : Rrt.Config.config -> format -> (unit, string) result
