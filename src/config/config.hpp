#ifndef _CONFIG_H_
#define _CONFIG_H_

#include <chrono>
#include <ctime>
#include <string>
#include <string_view>

using instant = std::chrono::time_point<std::chrono::system_clock>;

namespace Config {

// App's current version.
const std::string_view Version {"0.0.1"};

/*
A class containing configuration data needed to generate a release report.
*/
class Config final {
private:
  std::string m_url;
  std::string m_access_token;
  std::string m_env;
  unsigned long long m_number_of_months;
  instant m_start_date;

public:
  Config(
    std::string&& url,
    std::string&& access_token,
    std::string&& env,
    std::string&& start_date,
    unsigned long long number_of_months
  );

  std::string_view get_url() const noexcept;
  std::string_view get_env() const noexcept;
  instant get_start_date() const noexcept;
  u_int64_t get_month_count() const noexcept;

  // Pretty prints the configuration object to console.
  void pretty_print() const noexcept;

};

}

#endif
