#include "config.hpp"

#include <iomanip>
#include <ios>
#include <iostream>
#include <nlohmann/json.hpp>
#include <string>

namespace Config {
Config::Config(
    std::string&& url,
    std::string access_token,
    std::string env,
    std::string start_date,
    u_int64_t number_of_months
) : m_url{url},
    m_access_token{access_token},
    m_env{env},
    m_number_of_months{number_of_months} {
}

std::string_view Config::get_url() const noexcept { return m_url; }

std::string_view Config::get_env() const noexcept { return m_env; }

instant Config::get_start_date() const noexcept { return m_start_date; }

u_int64_t Config::get_month_count() const noexcept {
  return m_number_of_months;
}

void Config::pretty_print() const noexcept {
  std::cout << std::boolalpha << std::left;
  std::cout << std::setw(23) << "| Configuration " << " |" << "\n";
  std::cout << std::setw(23) << "| URL: " << m_url << " |\n";
  std::cout << std::setw(23) << "| Is access token set: " << !m_access_token.empty() << " |\n";
  std::cout << std::setw(23) << "| Environment: " << m_env << " |\n";
  std::cout << std::setw(23) << "| Start date: " << m_start_date << " |\n";
  std::cout << std::setw(23) << "| Number of months: " << m_number_of_months << " |\n";
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
