#include <print>

#include "cmd_args.hpp"

int main(int argc, char *argv[]) {
  CmdArgs cmdArgs {argc, argv};
  std::println("Parsed args: path = {}", cmdArgs.get_config_path());

  if (cmdArgs.get_format() == Report::Format::Unknown) {
    std::println("[Error] Unknown format");
    return 1;
  }

  return 0;
}
