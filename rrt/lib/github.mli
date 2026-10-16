(**
A module with types and functions related to release reports stored on GitHub.
*)

type release_author = {
    id : int;
    name : string;
    email : string option
}

type release_data = {
    id : int;
    name : string option;
    body : string option;
    tag_name : string;
    created_at : string; (* TODO: refactor to use actual date time record *)
    updated_at : string option; (* TODO: refactor to use actual date time record *)
    author : release_author
}
