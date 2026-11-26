#include "github.hpp"

#include <unordered_map>

namespace GitHub {

struct ReleaseAuthor {
  std::optional<std::string> email;
  std::string name;
  long long id;
};

struct ReleaseData {
  int id;
  std::optional<std::string> name;
  std::optional<std::string> body;
  std::string tag_name;
  std::chrono::system_clock::time_point created_at;
  std::optional<std::chrono::system_clock::time_point> updated_at;
};

std::unordered_map<std::string, std::string>
get_client_headers(std::string token) noexcept {
  return {
    {"Accept", "application/vnd.github+json"},
    {"X-GitHub-Api-Version", "2026-03-10"},
    /*("User-Agent", "ReleaseReportTool");*/
    {"Authorization", "Bearer " + token}
  };
}

std::vector<Repository::ReleaseData> GitHubDataFetcher::get_release_data(
  const Config::Config& cfg) const {
  return {};
}

}
