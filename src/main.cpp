#include <exception>
#include <fstream>
#include <memory>
#include <print>
#include <nlohmann/json.hpp>
#include <stop_token>
#include <thread>
#include <utility>

#include "config/cmd_args.hpp"
#include "config/config.hpp"
#include "report.hpp"
#include "repository/repository.hpp"

void generate_report(
  std::stop_token st,
  Repository::Type repo_type,
  Report::Format fmt,
  std::unique_ptr<Config::Config> cfg
);

int main(int argc, char* argv[]) {
  CmdArgs args {argc, argv};

  auto config_file_path {args.get_config_path()};
  // TODO: add config file path length validation
  if (!config_file_path.has_value()) {
    std::println("[Error] Path to a config file is missing");
    return 1;
  }

  Report::Format report_format {args.get_format()};
  if (report_format == Report::Format::Unknown) {
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
  config->pretty_print();

  Repository::Type repo_type {Repository::from_url(config->get_url())};
  if (repo_type == Repository::Unknown) {
    std::println("[Error] Couldn't detect a repository from URL");
    file_input.close();
    return 1;
  }

  file_input.close();

  std::jthread report_thread {
    generate_report,
    repo_type,
    report_format,
    std::move(config)
  };

  return 0;
}

void generate_report(
  std::stop_token st,
  Repository::Type repo_type,
  Report::Format fmt,
  std::unique_ptr<Config::Config> cfg) {
  if (!st.stop_requested()) {
  }
}
