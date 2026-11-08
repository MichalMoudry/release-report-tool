#include "cmd_args.hpp"
#include "report.hpp"

#include <optional>
#include <string>

std::optional<std::string> CmdArgs::get_config_path() const noexcept {
    return m_config_path;
}

Report::Format CmdArgs::get_format() const noexcept {
    return m_format;
}
