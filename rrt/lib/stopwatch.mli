type stopwatch = {
  start : Unix.tm;
  mutable finish : Unix.tm option;
  mutable elapsed : float
}

(**
Function for converting a {!Unix.tm} record to a ISO 8601 string.
@param time The record that should be converted.
@return The time as the ISO 8601 string.
@author Michal Moudrý
*)
val unix_tm_to_iso_string : Unix.tm -> string

(**
A function for calculating a difference (in seconds) two timestamps/dates.
@param start A timestamp that is the first part of the time interval.
@param finish A timestamp that is the second part of the time interval.
@return The difference between the two timestamps/dates.
@author Michal Moudrý
*)
val calculate_timestamp_diff : Unix.tm -> Unix.tm -> float

(**
A function for starting/creating a new {!stopwatch} instance.
@author Michal Moudrý
*)
val start_new : unit -> stopwatch

(**
Stops an instance of {!stopwatch} record. Stopping in this context means settin
a finish time and calculating how many seconds have elapsed.
@param sw The {!stopwatch} that should be stopped.
@return A number of seconds that elapsed since the {!stopwatch} was started.
@author Michal Moudrý
*)
val stop : stopwatch -> float
