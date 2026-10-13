(**
A module containing types and functions for handling this tool's configuration.
@author Michal Moudrý
*)

(**
An enum containing supported repositories for the release report.
@author Michal Moudrý
*)
type repository_type = GitHub

(**
A function for processing a URL and trying to detect a {!repository_type} from
it.
@param url The URL that should be processed.
@return The {!repository_type} that was detected from the URL.
@raise Failure If the function isn't able to detect any repository from the URL.
@author Michal Moudrý
*)
val get_repository_type : string -> repository_type

(** A structure containing tool's configuration data @author Michal Moudrý *)
type config = {
  url : string;
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
