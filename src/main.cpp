#include <string>
#include <print>

enum ReportFormat {
    Console = 'c',
    Html = 'h'
};

class CmdArgs final {
private:
    std::string m_config_path;
    ReportFormat m_format;

public:
    std::string get_config_path() const noexcept {
        return m_config_path;
    }

    ReportFormat get_format() const noexcept {
        return m_format;
    }

    void set_config_path() noexcept {

    }

    void set_format() noexcept {

    }
};

int main(int argc, char* argv[]) {
    auto args {CmdArgs{}};

    for (auto i = 0; i < argc; i++) {
        auto current {argv[i]};
        
        std::println("{}: {}", i, current);
    }

    return 0;
}
