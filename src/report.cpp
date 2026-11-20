#include "report.hpp"

std::ostream& operator<<(std::ostream& os, Report::Format format) noexcept {
  switch (format) {
    case Report::Format::Console: os << "Console"; break;
    default: os << "Unknown";
  }
  return os;
}
