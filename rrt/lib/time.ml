(**
A module that contains types and functions for dealing with date and time
related things.
@author Michal Moudrý
*)

(** A type representing the date part of a date time. @author Michal Moudrý *)
type dateonly = {
  year : int;
  month : int;
  day : int
}

(**
Parses a string, and then tries to create a dateonly record out of it.
@param str The string that should be parsed into the dateonly record
@return A Some of dateonly record if it's correctly parsed; otherwise, None.
@author Michal Moudrý
*)
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

(**
Effectively a `.ToString()` method for the dateonly record.
@param date A date that should converted to a string
@return A string with containing the date's information
@author Michal Moudrý
*)
let dateonly_to_string date =
  Format.sprintf "%i-%i-%i"
  date.year
  date.month
  date.day
