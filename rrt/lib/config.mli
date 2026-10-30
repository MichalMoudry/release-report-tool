(**
A module containing types and functions for handling this tool's configuration.
@author Michal Moudrý
*)

(**
A module providing types and functions related to a repository that the release
report should be generated for.
@author Michal Moudrý
*)
module Repository : sig
  type t = GitHub
  (**
  An enum containing supported repositories for the release report.
  @author Michal Moudrý
  *)

  val get_type : string -> t
  (**
  A function for processing a URL and trying to detect a {!t} from
  it.
  @param url The URL that should be processed.
  @return The {!t} that was detected from the URL.
  @raise Failure If the function isn't able to detect any repository from the URL.
  @author Michal Moudrý
  *)

  val type_to_string : t -> string
  (**
  A function that converts a {!t} to a string representation.
  @param repo A type of repository.
  @author Michal Moudrý
  *)
end

(** A structure containing tool's configuration data @author Michal Moudrý *)
type config = {
  url : string;
  repo_type : Repository.t option;
  access_token : string option;
  environment : string option;
  start_date : Time.dateonly;
  number_of_months : int
}

(**
Retrieves configuration information from a file.
@param str A JSON string that should be deserialised to the {!config} record.
@return An instance of config record.
@raise Invalid_config_field If any of the required JSON fields are missing.
@author Michal Moudrý
*)
val get_config : string -> config

(**
Pretty prints a recived {!config} object.
@param cfg The {!config} object that should be pretty printed.
@author Michal Moudrý
*)
val pp_config : config -> unit
