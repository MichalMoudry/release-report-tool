#include "config.hpp"

#include <iomanip>
#include <nlohmann/json.hpp>

namespace Config {
Config::Config(
    std::string url,
    std::string access_token,
    std::string env,
    std::string start_date,
    u_int64_t number_of_months
) : m_url{url},
    m_access_token{access_token},
    m_env{env},
    m_number_of_months{number_of_months},
    m_repo_type{Repository::from_url(url)} {
    std::get_time(&m_start_date, "");
}

std::string Config::get_url() const noexcept { return m_url; }

std::string Config::get_env() const noexcept { return m_env; }

std::tm Config::get_start_date() const noexcept { return m_start_date; }

u_int64_t Config::get_month_count() const noexcept {
  return m_number_of_months;
}

Repository::Type Config::get_type() const noexcept {
  return m_repo_type;
}

std::unique_ptr<Config> from_json(const nlohmann::json& json) {
  return std::make_unique<Config>(
    json["url"].get<std::string>(),
    json["accessToken"].get<std::string>(),
    json["environment"].get<std::string>(),
    json["startDate"].get<std::string>(),
    json["numberOfMonths"].get<u_int64_t>()
  );
}
}
