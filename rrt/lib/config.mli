(** A structure containing tool's configuration data *)
type config = { url : string; access_token : string option; }
(** Retrieves configuration information from a file *)
val get_config : string -> config
val print_config : config -> config
