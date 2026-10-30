(**
A module providing types and functions around a release report.
@author Michal Moudrý
*)

type format

(**
Returns a release report format based on a provided string.
@raise Failure if the string is outside of a range of expected values.
*)
val get_format : string -> format

(**
A function that retrieves report data, and then constructs the report according
to a specified format.
@param format The desired {!format} that the report should be in.
@param fetch A function that fetches report data from a source code repository.
@author Michal Moudrý
*)
val create : Rrt.Config.config
    -> format
    -> (string -> (string, string) result)
    -> (unit, string) result

(**
A function for creating an error message related to a creation of the release
report.
@param message A piece of text that should be a part of the message.
@author Michal Moudrý
*)
val create_err_message : string -> string
