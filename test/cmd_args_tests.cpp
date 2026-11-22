#include "cmd_args_tests.hpp"
#include "../src/config/cmd_args.hpp"

#include <iostream>

// A test that checks if a valid set of arguments is correctly parsed.
int test_correct_args_parsing() noexcept {
  char config_flag[3] {"-c"};
  char config_path[9] {"./config"};

  char format_flag[3] {"-f"};
  char format[8] {"Console"};

  char* values [] {config_flag, config_path, format_flag, format};
  CmdArgs args {4, values};

  auto actual_path {args.get_config_path()};
  auto has_path {actual_path.has_value()};
  if (!has_path || actual_path->compare(config_path) != 0) {
    std::cerr
      << "Config isn't set or has an invalid value. Expected: "
      << config_path
      << ", got: "
      << (has_path ? actual_path.value() : "no path")
      << std::endl;
    return 1;
  }

  Report::Format actual_format {args.get_format()};
  if (actual_format != Report::Format::Console) {
    std::cerr << "Format isn't Console, got: " << actual_format << std::endl;
    return 1;
  }

  return 0;
}

int test_args_parsing_with_zero_arg_count() noexcept {
  char arg1[] {"-c"};
  char arg2[] {"./config.json"};
  char* argv [] {arg1, arg2};
  CmdArgs args {0, argv};

  auto config_path {args.get_config_path()};
  if (config_path.has_value()) {
    std::cerr
      << "The config path was somehow set, got "
      << config_path.value() << std::endl;
    return 1;
  }

  Report::Format format {args.get_format()};
  if (format != Report::Format::Unknown) {
    std::cerr
      << "The report format should be unknown, got "
      << format << std::endl;
    return 1;
  }

  return 0;
}
