(**
A module containing types and functions for handling this tool's configuration.
@author Michal Moudrý
*)

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
@param str A JSON string that should be deserialised to the config record.
@return An instance of config record.
@raise Invalid_config_field If any of the required JSON fields are missing.
@author Michal Moudrý
*)
val get_config : string -> config

(**
Pretty prints a recived config object.
@param cfg The config object that should be pretty printed.
@author Michal Moudrý
*)
val pp_config : config -> unit
