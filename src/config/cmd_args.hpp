#ifndef _CMD_ARGS_H_
#define _CMD_ARGS_H_

#include <optional>
#include <string>

#include "../report.hpp"

// A class that holds required command-line arguments.
class CmdArgs final {
private:
  std::optional<std::string> m_config_path;
  Report::Format m_format;

  void set_format(std::string input) noexcept {
    if (input.compare("Console") == 0) {
      m_format = Report::Format::Console;
    } else if (input.compare("HTML") == 0) {
      m_format = Report::Format::Html;
    } else {
      m_format = Report::Format::Unknown;
    }
  }

public:
  CmdArgs() = default;

  // A constructor for initialising the class from program's own arguments.
  CmdArgs(int argc, char *argv[]) {
    for (int i = 0; i < argc; i++) {
      std::string current {std::string{argv[i]}};

      bool is_not_last {i != argc - 1};
      if (current.compare("-c") == 0 && is_not_last) {
        m_config_path = std::make_optional(argv[i + 1]);
      } else if (current.compare("-f") && is_not_last) {
        set_format(argv[i + 1]);
      }
    }
  }

  // Returns a path to config file that a user specified.
  std::optional<std::string> get_config_path() const noexcept;

  /*
  Returns a format of the release report. This is specified by the user, and
  can be unknown.
  */
  Report::Format get_format() const noexcept;
};

#endif
