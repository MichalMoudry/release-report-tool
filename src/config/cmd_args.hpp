#ifndef _CMD_ARGS_H_
#define _CMD_ARGS_H_

#include <optional>
#include <string>

#include "../core/report.hpp"

// A class that holds required command-line arguments.
class CmdArgs final {
private:
  std::optional<std::string> m_config_path;
  Report::Format m_format;

public:
  // A constructor for initialising the class from program's own arguments.
  CmdArgs(int argc, char* argv[]);

  // Returns a path to config file that a user specified.
  std::optional<std::string> get_config_path() const noexcept;

  /*
  Returns a format of the release report. This is specified by the user, and
  can be unknown.
  */
  Report::Format get_format() const noexcept;
};

#endif
