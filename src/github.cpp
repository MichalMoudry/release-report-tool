#include "github.hpp"

namespace GitHub {
std::unordered_map<std::string, std::string>
get_client_headers(std::string token) noexcept {
  return {
    {"Accept", "application/vnd.github+json"},
    {"X-GitHub-Api-Version", "2026-03-10"},
    {"Authorization", "Bearer " + token}
  };
}
}
