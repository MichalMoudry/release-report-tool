module Repository = struct
  type t = GitHub

  let get_type url =
    if String.includes ~affix:"github" url then
      GitHub
    else
      failwith "Unable to detect a repository type from URL"

  let type_to_string repo =
    match repo with
    | GitHub -> "GitHub"
end

type config = {
  url : string;
  repo_type : Repository.t option;
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

(**
A function that "overrides" a provided access token with a value from an
environment variable.
@param token An optional access token.
@return If "ACCESS_TOKEN" environment variable is set, then it's returned;
otherwise, token argument is returned.
@author Michal Moudrý
*)
let set_access_token token =
  let token_from_env = Sys.getenv_opt "ACCESS_TOKEN" in
  if Option.is_some token_from_env then
    token_from_env
  else
    match token with
    | Some value -> if value = "" then None else token
    | None -> None

(**
A function for setting a {!repository_type} to a {!config} record.
@param cfg An instance of the {!config} record.
@author Michal Moudrý
*)
let set_repository_type cfg =
  { cfg with repo_type = Some (Repository.get_type cfg.url) }

(**
Function for transforming a JSON object to an internal representation.
@param json A JSON object that should be deserialised into {!config}.
@return An instance of {!config} record.
@author Michal Moudrý
*)
let new_config json =
  let open Yojson.Safe.Util in
  {
    url = json |> member "url" |> to_string_option |> validate_member "url";
    repo_type = None;
    access_token = json
      |> member "accessToken"
      |> to_string_option
      |> set_access_token;
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
  } |> set_repository_type

let get_config str = Yojson.Safe.from_string str |> new_config

let pp_config cfg = Format.printf {|Configuration = [ @[
  Repository URL      = %s,
  Repository type     = %s,
  Is access token set = %b,
  Environment         = %s,
  Start date          = %s,
  Number of months    = %i @]
]|}
  cfg.url
  (match cfg.repo_type with
    | Some value -> Repository.type_to_string value
    | None -> "")
  (Option.is_some cfg.access_token)
  (match cfg.environment with | Some env -> env | None -> "")
  (Time.dateonly_to_string cfg.start_date)
  cfg.number_of_months;
  Format.print_newline ()
