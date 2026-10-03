(** A structure containing tool's configuration data *)
type config = {
  url : string;
  access_token : string option;
  environment : string option;
  start_date : string;
  number_of_months : int
}

(** Function for transforming a JSON object to an internal representation. *)
let new_config json =
  let open Yojson.Safe.Util in
  {
    url = json |> member "url" |> to_string;
    access_token = json |> member "accessToken" |> to_string_option;
    environment = json |> member "environment" |> to_string_option;
    start_date = "";
    number_of_months = json |> member "numberOfMonths" |> to_int
  }

(** Retrieves configuration information from a file. *)
let get_config str = Yojson.Safe.from_string str |> new_config

(** Pretty prints a recived config object, and returns it back. *)
let pp_config cfg =
  Format.printf "== Configuration:@ @[URL@ =@ %s,@ Is access token set = %b@]@." cfg.url (Option.is_some cfg.access_token);
  cfg
