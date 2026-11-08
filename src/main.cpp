#include <print>

#include "cmd_args.hpp"

int main(int argc, char *argv[]) {
  CmdArgs cmdArgs {argc, argv};

  auto config_file_path {cmdArgs.get_config_path()};
  // TODO: add config file path length validation
  if (!config_file_path.has_value()) {
    std::println("[Error] Path to a config file is missing");
    return 1;
  }
  std::println("Config file path = {}", config_file_path.value());

  if (cmdArgs.get_format() == Report::Format::Unknown) {
    std::println("[Error] Unknown format");
    return 1;
  }

  return 0;
}
