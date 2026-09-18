let usage_msg = "rrt []"

let anon_fun value = print_endline ("Received: " ^ value)

let help () = print_endline "This is a help info"

let spec_list =
  [
    ("--help", Arg.Unit help, "Displays tool's help information")
  ]

let main () =
  Arg.parse spec_list anon_fun usage_msg

let () =
  print_endline "Running!";
  main()
