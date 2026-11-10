#include "config.hpp"
#include <iomanip>

Config::Config(
    std::string url,
    std::string access_token,
    std::string env,
    std::string start_date,
    u_int64_t number_of_months
) : m_url{url},
    m_access_token{access_token},
    m_env{env},
    m_number_of_months{number_of_months} {
    std::get_time(&m_start_date, "");
}
