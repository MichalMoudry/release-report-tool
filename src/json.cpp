#include "json.hpp"

#include <nlohmann/json.hpp>

std::unique_ptr<Config::Config> Json::config_from_json(
  const nlohmann::json &json) noexcept {
  return std::make_unique<Config::Config>(
    json["url"].get<std::string>(),
    json["accessToken"].get<std::string>(),
    json["environment"].get<std::string>(),
    json["startDate"].get<std::string>(),
    json["numberOfMonths"].get<u_int64_t>()
  );
}
