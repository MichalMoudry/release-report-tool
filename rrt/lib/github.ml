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
    created_at : string;
    updated_at : string option;
    author : release_author
}
