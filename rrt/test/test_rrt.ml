let test_get_config () =
  let json = {|{"url": "http://localhost"}|} in
  let config = Rrt.Config.get_config json in
  Alcotest.(check string) "is URL equal" "http://localhost" config.url

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
