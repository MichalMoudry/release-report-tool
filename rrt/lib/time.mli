(**
A module that contains types and functions for dealing with date and time
related things.
@author Michal Moudrý
*)

(** A type representing the date part of a date time. @author Michal Moudrý *)
type dateonly = { year : int; month : int; day : int }

(**
Parses a string, and then tries to create a {!dateonly} record out of it.
@param str The string that should be parsed into the {!dateonly} record.
@return A Some of {!dateonly} record if it's correctly parsed; otherwise, None.
@author Michal Moudrý
*)
val new_dateonly : string option -> dateonly option

(**
Effectively a `.ToString()` method for the {!dateonly} record.
@param date A date that should converted to a string
@return A string with containing the date's information
@author Michal Moudrý
*)
val dateonly_to_string : dateonly -> string
