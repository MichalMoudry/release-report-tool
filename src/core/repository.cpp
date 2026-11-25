#include "repository.hpp"

namespace Repository {
Type from_url(std::string_view url) noexcept {
  if (url.contains("github")) {
    return GitHub;
  }
  return Unknown;
}

std::string_view url_to_string(Type type) noexcept {
  switch (type) {
  case GitHub:
    return "GitHub";
  case Unknown:
    return "Unknown";
  }
}
}
