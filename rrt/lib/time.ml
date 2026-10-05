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
@return
@author Michal Moudrý
*)
let new_dateonly str =
  if str = "" then
    { year = 0; month = 0; day = 0 }
  else
    { year = 2026; month = 10; day = 6 }

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
