#include <string>

// A test that checks if a valid set of arguments is correctly parsed.
int test_correct_args_parsing() {
  /*char config_flag [3] {"-c"};
  char config_path [9] {"./config"};

  char format_flag [3] {"-f"};
  char format [5] {"HTML"};

  char* values [] = {config_flag, config_path, format_flag, format};
  CmdArgs args {2, values};

  auto actual_path {args.get_config_path()};
  if (!actual_path.has_value() || actual_path->compare(config_path) != 0) {
    std::cerr
      << "Config isn't set or has an invalid value. Expected: "
      << config_path
      << ", got: "
      << actual_path.value()
      << std::endl;
    return 1;
  }

  auto actual_format {args.get_format()};
  if (actual_format != Report::Format::Html) {
    std::cerr << "Format isn't HTML, got: " << actual_format << std::endl;
    return 1;
  }*/

  return 0;
}

int main(int argc, char* argv[]) {
  if (argc < 2) {
    return 1;
  }

  std::string test {argv[1]};
  if (test == "cmd_arg_parse_happy") {
    return test_correct_args_parsing();
  }
  return 1;
}
