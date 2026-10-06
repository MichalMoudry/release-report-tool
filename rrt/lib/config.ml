type config = {
  url : string;
  access_token : string option;
  environment : string option;
  start_date : Time.dateonly;
  number_of_months : int
}

(**
Validates a config field that should not be empty.
@param fieldName A name of the field/member that's being validated.
@param opt An optional that's being validated.
@return The value of the field/member, if it isn't None.
@raise Invalid_config_field If the opt param is None.
@author Michal Moudrý
*)
let validate_member fieldName opt =
  match opt with
  | Some value -> value
  | None -> failwith ("'" ^ fieldName ^ "' is empty")

(** Function for transforming a JSON object to an internal representation. *)
let new_config json =
  let open Yojson.Safe.Util in
  {
    url = json |> member "url" |> to_string_option |> validate_member "url";
    access_token = json |> member "accessToken" |> to_string_option;
    environment = json |> member "environment" |> to_string_option;
    start_date = json
      |> member "startDate"
      |> to_string_option
      |> Time.new_dateonly
      |> validate_member "startDate";
    number_of_months = json
      |> member "numberOfMonths"
      |> to_int_option
      |> validate_member "numberOfMonths"
  }

let get_config str = Yojson.Safe.from_string str |> new_config

let pp_config cfg = Format.printf {|Configuration = [ @[
  Repository URL      = %s,
  Is access token set = %b,
  Environment         = %s,
  Start date          = %s,
  Number of months    = %i @]
]|}
  cfg.url
  (Option.is_some cfg.access_token)
  (match cfg.environment with | Some env -> env | None -> "")
  (Time.dateonly_to_string cfg.start_date)
  cfg.number_of_months;
  Format.print_newline ()
