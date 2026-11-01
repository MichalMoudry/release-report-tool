(**
A module with types and functions related to release reports stored on GitHub.
*)

(**
A record containing data about a person that authored a release.
@author Michal Moudrý
*)
type release_author

(**
A record containing data about a release stored on GitHub.
@author Michal Moudrý
*)
type release_data

(**
A function that returns a list of HTTP headers needed for a GitHub's API
request.
@param token An authentication token.
@return A list of tuples that represent the headers.
@author Michal Moudrý
*)
val get_client_headers : string -> (string * string) list
