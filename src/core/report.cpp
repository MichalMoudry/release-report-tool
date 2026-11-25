#include "report.hpp"

namespace Report {

std::ostream& operator<<(std::ostream& os, Report::Format format) noexcept {
  switch (format) {
    case Report::Format::Console: os << "Console"; break;
    default: os << "Unknown";
  }
  return os;
}

void generate(
  std::stop_token st,
  std::promise<Result> &promise,
  Repository::Type repo_type,
  Format fmt,
  std::unique_ptr<Config::Config> cfg) {
  if (!st.stop_requested()) {
    promise.set_value(Report::Result::Undetermined);
  }
}

}
