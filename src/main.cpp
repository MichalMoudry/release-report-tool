#include <fstream>
#include <memory>
#include <print>

#include "cmd_args.hpp"
#include "config.hpp"
#include "nlohmann/json.hpp"

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

  nlohmann::json json;
  try {
    json = nlohmann::json::parse(file_input);
  } catch (const nlohmann::json::parse_error& e) {
    std::println("[Error] Failed to parse config file, reason: {}", e.what());
    return 1;
  }

  /*Config app_config {
    "url", // json["url"].get<std::string>(),
    "token", // json["accessToken"].get<std::string>(),
    "env", // json["env"].get<std::string>(),
    "2026-01-01", // json["startDate"].get<std::string>(),
    0
  };*/

  std::unique_ptr<Config> config {std::make_unique<Config>(
    json["url"].get<std::string>(),
    "token",
    "env",
    "2026-01-01",
    0
  )};
  std::println("{}", *config);

  file_input.close();

  return 0;
}
