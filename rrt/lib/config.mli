(** A structure containing tool's configuration data *)
type config = {
  url : string;
  access_token : string option;
  environment : string option;
  start_date : string;
  number_of_months : int
}

(** Retrieves configuration information from a file. *)
val get_config : string -> config
(** Pretty prints a recived config object, and returns it back. *)
val pp_config : config -> config
