#include <string>

#include "cmd_args_tests.hpp"

int main(int argc, char* argv[]) {
  if (argc < 2) {
    return 1;
  }

  std::string test {argv[1]};
  if (test == "cmd_arg_parse_happy") {
    return test_correct_args_parsing();
  } else if (test == "test_args_parsing_with_zero_arg_count") {
    return test_args_parsing_with_zero_arg_count();
  }
  return 1;
}
