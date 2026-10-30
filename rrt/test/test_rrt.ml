let test_get_config () =
  let json = {|{"url": "http://localhost"}|} in
  let config = Rrt.Config.get_config json in
  Alcotest.(check string) "is URL equal" "http://localhost" config.url

(**
A test case that asserts that the {!Rrt.Config.get_repository_type} correctly
converts strings to an internal repository representation.
@author Michal Moudrý
*)
let test_get_repository_type url expected () =
  let repository_type = Rrt.Config.Repository.get_type url in
  let msg = "URL " ^ url ^ " couldn't be processed to a correct type" in
  Alcotest.(check bool) msg true (expected = repository_type)

(**
A test case that checks if the {!Rrt.Config.get_repository_type} function
correctly throws when an invalid URL is provided.
@author Michal Moudrý
*)
let test_get_repository_type_throwing url () =
  let res = try Some (Rrt.Config.Repository.get_type url) with e -> None in
  let msg = match res with
    | Some value -> "Invalid URL was somehow correctly processed, got "
      ^ (Rrt.Config.Repository.type_to_string value)
    | _ -> "" in
  Alcotest.(check bool) msg true (Option.is_none res)

let test_unix_tm_to_iso_string seconds expected () =
  let timestamp = Unix.gmtime seconds in
  let time_str = Rrt.Stopwatch.unix_tm_to_iso_string timestamp in
  Alcotest.(check string) "same ISO 8601 string" expected time_str

(** A test function for validating  *)
let test_calculate_timestamp_diff start finish expected () =
  let diff = Rrt.Stopwatch.calculate_timestamp_diff start finish in
  let message = Format.sprintf "expected %.4f, got %.4f" expected diff in
  Alcotest.(check bool) message true (expected = diff)

let config_tests =
  [
    (*"can deserialize JSON to config", `Quick, test_get_config*)

    "can process GitHub URL",
    `Quick,
    test_get_repository_type
      "https://github.com/MichalMoudry/release-report-tool"
      Rrt.Config.Repository.GitHub;

    "correctly throws when processing invalid repo URL",
    `Quick,
    test_get_repository_type_throwing "http://localhost";

    "correctly throws when processing an empty string as a repo URL",
    `Quick,
    test_get_repository_type_throwing ""
  ]

(** A test suite with test cases for `unix_tm_to_string` function. *)
let stopwatch_tests = [
  "can zero seconds convert Unix.tm to string",
  `Quick,
  test_unix_tm_to_iso_string 0. "1970-01-01T00-00-00Z";

  "can non-zero seconds convert Unix.tm to string",
  `Quick,
  test_unix_tm_to_iso_string 1_791_590_475. "2026-10-10T00-01-15Z";

  "is time difference caluclated correctly",
  `Quick,
  test_calculate_timestamp_diff (Unix.gmtime 1_791_590_475.) (Unix.gmtime 1_791_590_575.) 100.
]

let () =
  Alcotest.run "Rrt" [
    ("Config", config_tests);
    ("Stopwatch", stopwatch_tests)
  ]
