(**
A module containing definitions of tool's own errors
@author Michal Moudrý
*)

(** An exception that signals an invalid value of a configuration field. *)
exception Invalid_config_field of string
