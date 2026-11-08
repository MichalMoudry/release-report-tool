#ifndef _CMD_ARGS_H_
#define _CMD_ARGS_H_

#include <string>
#include "report.hpp"

class CmdArgs final {
private:
  std::string m_config_path;
  Report::Format m_format;

  void set_format(std::string input) noexcept {
    if (input.compare("Console")) {
      m_format = Report::Format::Console;
    } else if (input.compare("HTML")) {
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

      bool is_not_last {i != argc};
      if (current.compare("-c") && is_not_last) {
        m_config_path = argv[i + 1];
      } else if (current.compare("-f")) {
        set_format(argv[i + 1]);
      }
    }
  }

  std::string get_config_path() const noexcept { return m_config_path; }

  Report::Format get_format() const noexcept { return m_format; }
};

#endif