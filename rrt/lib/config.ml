(** A structure containing tool's configuration data *)
type config = {
  url : string;
  access_token : string option;
  environment : string option;
  start_date : Time.dateonly;
  number_of_months : int
}

(** Function for transforming a JSON object to an internal representation. *)
let new_config json =
  let open Yojson.Safe.Util in
  {
    url = json |> member "url" |> to_string;
    access_token = json |> member "accessToken" |> to_string_option;
    environment = json |> member "environment" |> to_string_option;
    start_date = json |> member "startDate" |> to_string |> Time.new_dateonly;
    number_of_months = json |> member "numberOfMonths" |> to_int
  }

(** Retrieves configuration information from a file. *)
let get_config str = Yojson.Safe.from_string str |> new_config

(** Pretty prints a recived config object *)
let pp_config cfg = Format.printf {|Configuration = [ @[
  Repository URL      = %s,
  Is access token set = %b,
  Environment         = %s,
  Start date          = %s,
  Number of months    = %i,
  Additional sources  = [] @]
]|}
  cfg.url
  (Option.is_some cfg.access_token)
  (match cfg.environment with | Some env -> env | None -> "")
  (Time.dateonly_to_string cfg.start_date)
  cfg.number_of_months;
  Format.print_newline ()
