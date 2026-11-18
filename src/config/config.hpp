#ifndef _CONFIG_H_
#define _CONFIG_H_

#include "nlohmann/json_fwd.hpp"

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
  unsigned long long m_number_of_months;

public:
  Config(
    std::string url,
    std::string access_token,
    std::string env,
    std::string start_date,
    unsigned long long number_of_months
  );

  std::string get_url() const noexcept;
  std::string get_env() const noexcept;
  std::tm get_start_date() const noexcept;
  u_int64_t get_month_count() const noexcept;

  void pretty_print() const noexcept;
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
        "Config {{ url = {}, env = {}, start_date = {}, number_of_months = {} }}",
        cfg.get_url(),
        cfg.get_env(),
        "",
        cfg.get_month_count()
      ),
      ctx
    );
  }
};

#endif
