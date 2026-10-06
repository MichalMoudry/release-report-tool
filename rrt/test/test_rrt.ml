open Alcotest

let test_get_config () =
  let json = {|{"url": "http://localhost"}|} in
  let config = Rrt.Config.get_config json in
  check string "is URL equal" "http://localhost" config.url

let suite =
  [
    "can deserialize JSON to config", `Quick, test_get_config
  ]

let () =
  Alcotest.run "Rrt" [ "Config", suite ]
