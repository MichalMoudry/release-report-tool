#ifndef _REPOSITORY_H_
#define _REPOSITORY_H_

#include <string>
#include <vector>

#include "../config/config.hpp"

namespace Repository {
/*
An enum containing supported repositories for the release report.
@author Michal Moudrý
*/
enum Type { Unknown = 0, GitHub = 1 };

/*
A function for processing a URL and trying to detect a {!Type} from it.
*/
Type from_url(std::string url) noexcept;

std::string_view url_to_string(Type type) noexcept;

struct ReleaseData final {
  long long int id;
  std::vector<std::string> approvers;
  std::string created_at;
  std::string updated_at;
};

/*
An interface for a class that's responsible for fetching a collection of
release information.
*/
class DataFetcher {
  public:
  virtual std::vector<ReleaseData> get_release_data(
    const Config::Config& cfg
  ) = 0;
};
}

#endif
