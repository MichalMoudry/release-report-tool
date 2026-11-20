#include "cmd_args.hpp"

CmdArgs::CmdArgs(int argc, char *argv[]) {
  for (int i = 0; i < argc; i++) {
    std::string current {std::string{argv[i]}};
    bool is_not_last {i != argc - 1};

    if (current == "-c" && is_not_last) {
      m_config_path = std::make_optional(argv[i + 1]);
    } else if (current == "-f" && is_not_last) {
      std::string input {argv[i + 1]};
      if (input == "Console") {
        m_format = Report::Format::Console;
      } else {
        m_format = Report::Format::Unknown;
      }
    }
  }
}

std::optional<std::string> CmdArgs::get_config_path() const noexcept {
  return m_config_path;
}

Report::Format CmdArgs::get_format() const noexcept { return m_format; }
