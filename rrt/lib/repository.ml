(**
A module providing types and functions related to a repository that the release
report should be generated for.
@author Michal Moudrý
*)

type t = GitHub
(**
An enum containing supported repositories for the release report.
@author Michal Moudrý
*)

(**
A function for processing a URL and trying to detect a {!t} from
it.
@param url The URL that should be processed.
@return The {!t} that was detected from the URL.
@raise Failure If the function isn't able to detect any repository from the URL.
@author Michal Moudrý
*)
let from_url url =
  if String.includes ~affix:"github" url then
    GitHub
  else
    failwith "Unable to detect a repository type from URL"

(**
A function that converts a {!t} to a string representation.
@param repo A type of repository.
@author Michal Moudrý
*)
let to_string repo =
  match repo with
  | GitHub -> "GitHub"
