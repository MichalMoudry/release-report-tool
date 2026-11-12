#ifndef _CONFIG_H_
#define _CONFIG_H_

#include <ctime>
#include <format>
#include <string>
#include <string_view>

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

    std::string get_url() const noexcept;
    std::tm get_start_date() const noexcept;
};

template <>
struct std::formatter<Config> : std::formatter<std::string_view> {
    auto format(const Config& cfg, std::format_context& ctx) const {
        return std::formatter<std::string_view>::format(
            std::format(
                "Config {{ url = {}, start_date = {} }}",
                cfg.get_url(),
                cfg.get_start_date().tm_year
            ),
            ctx
        );
    }
};

#endif
