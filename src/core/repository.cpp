#include "repository.hpp"
#include "github.hpp"
#include <memory>
#include <optional>

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

std::optional<std::unique_ptr<IDataProvider>> construct_data_provider(
  Type repo_type) noexcept {
  switch (repo_type) {
    case GitHub:
      return std::make_unique<GitHub::GitHubDataFetcher>();
    case Unknown:
      return std::nullopt;
  }
}

}
