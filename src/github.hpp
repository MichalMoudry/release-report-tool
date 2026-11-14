#ifndef _GITHUB_H_
#define _GITHUB_H_

#include <chrono>
#include <optional>
#include <string>
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

/*
Returns a map of HTTP request headers needed to send requests to GitHub's API.
*/
std::unordered_map<std::string, std::string>
get_client_headers(std::string token) noexcept;
}

#endif
