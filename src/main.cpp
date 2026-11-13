#include <exception>
#include <fstream>
#include <memory>
#include <print>
#include <nlohmann/json.hpp>

#include "cmd_args.hpp"
#include "config.hpp"

int main(int argc, char *argv[]) {
  CmdArgs cmdArgs {argc, argv};

  auto config_file_path {cmdArgs.get_config_path()};
  // TODO: add config file path length validation
  if (!config_file_path.has_value()) {
    std::println("[Error] Path to a config file is missing");
    return 1;
  }

  if (cmdArgs.get_format() == Report::Format::Unknown) {
    std::println("[Error] Unknown format");
    return 1;
  }

  std::ifstream file_input {config_file_path.value()};
  if (!file_input.is_open()) {
    std::println("[Error] The config file couldn't be opened");
    return 1;
  }

  std::unique_ptr<Config::Config> config = nullptr;
  try {
    config = Config::from_json(nlohmann::json::parse(file_input));
  } catch (const std::exception& e) {
    std::println("[Error] Failed to parse config, reason:\n{}", e.what());
    file_input.close();
    return 1;
  }
  std::println("{}", *config);

  file_input.close();
  return 0;
}
