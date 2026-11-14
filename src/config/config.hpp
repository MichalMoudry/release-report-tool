#ifndef _CONFIG_H_
#define _CONFIG_H_

#include "nlohmann/json_fwd.hpp"
#include "../repository.hpp"

#include <ctime>
#include <format>
#include <memory>
#include <string>
#include <string_view>

namespace Config {
/*
A class containing configuration data needed to generate a release report.
*/
class Config final {
private:
  std::tm m_start_date;
  std::string m_url;
  std::string m_access_token;
  std::string m_env;
  unsigned long long int m_number_of_months;
  Repository::Type m_repo_type;

public:
  Config(
    std::string url,
    std::string access_token,
    std::string env,
    std::string start_date,
    u_int64_t number_of_months
  );

  std::string get_url() const noexcept;
  std::string get_env() const noexcept;
  std::tm get_start_date() const noexcept;
  u_int64_t get_month_count() const noexcept;
  Repository::Type get_type() const noexcept;
};

/*
Uses JSON values as config values from a provided parsed JSON object.
*/
std::unique_ptr<Config> from_json(const nlohmann::json &json);
}

template <>
struct std::formatter<Config::Config> : std::formatter<std::string_view> {
  auto format(const Config::Config &cfg, std::format_context &ctx) const {
    return std::formatter<std::string_view>::format(
      std::format(
        "Config {{ url = {}, type = {}, env = {}, start_date = {}, number_of_months = {} }}",
        cfg.get_url(),
        Repository::url_to_string(cfg.get_type()),
        cfg.get_env(),
        "",
        cfg.get_month_count()
      ),
      ctx
    );
  }
};

#endif
