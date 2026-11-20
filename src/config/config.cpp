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
  auto separator = std::string(m_url.length() + 25, '-');
  // TODO: maybe truncate URL (or any data for that matter), so that it doesn't
  // exceed 80 column
  std::cout << separator << '\n';
  std::cout << "| " << std::setw(72) << std::left << "Configuration " << " |\n";
  std::cout << separator << '\n';
  std::cout
    << "| " << std::setw(21) << "URL: "
    << std::setw(51) << m_url << " |\n";
  std::cout
    << "| " << std::setw(21) << "Is access token set: "
    << std::setw(51) << !m_access_token.empty() << " |\n";
  std::cout
    << "| " << std::setw(21) << "Environment: "
    << std::setw(51) << m_env << " |\n";
  std::cout
    << "| " << std::setw(21) << "Start date: "
    << std::setw(51) << m_start_date << " |\n";
  std::cout
    << "| " << std::setw(21) << "Number of months: "
    << std::setw(51) << m_number_of_months << " |\n";
  std::cout << separator << std::endl;
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
