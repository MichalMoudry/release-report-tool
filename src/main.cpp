#include <fstream>
#include <print>
#include <string>

#include "cmd_args.hpp"
#include "../lib/nlohmann_json_3_12_0/json.hpp"
#include "config.hpp"

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

  std::ifstream file_input {config_file_path.value()};
  if (!file_input.is_open()) {
    std::println("[Error] The config file couldn't be opened");
    return 1;
  }

  auto json {nlohmann::json::parse(file_input)};
  std::println("Config file content = {}", json.dump());
  // Maybe allocate to heap?
  Config app_config {
    json["url"].get<std::string>(),
    json["accessToken"].get<std::string>(),
    json["env"].get<std::string>(),
    json["startDate"].get<std::string>(),
    0
  };

  file_input.close();

  return 0;
}
