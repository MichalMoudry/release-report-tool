#ifndef _CONFIG_H_
#define _CONFIG_H_

#include <ctime>
#include <string>

class Config final {
private:
    std::tm m_start_date;
    std::string m_url;
    std::string m_access_token;
    std::string m_env;
    u_int64_t m_number_of_months;

public:
    Config(
        std::string url,
        std::string access_token,
        std::string env,
        std::string start_date,
        u_int64_t number_of_months
    );
};

#endif
