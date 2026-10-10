type dateonly = { year : int; month : int; day : int }

let new_dateonly str =
  if Option.is_none str then
    None
  else
    let str_parts = String.split_on_char '-' (Option.get str) in
    if List.length str_parts <> 3 then
      None
    else
      let year_str = int_of_string_opt (List.nth str_parts 0) in
      let month_str = int_of_string_opt (List.nth str_parts 1) in
      let day_str = int_of_string_opt (List.nth str_parts 2) in
      Some {
        year = (match year_str with Some value -> value | None -> 0);
        month = (match month_str with Some value -> value | None -> 0);
        day = (match day_str with Some value -> value | None -> 0)
      }

let dateonly_to_string date =
  Format.sprintf "%i-%i-%i"
  date.year
  date.month
  date.day
