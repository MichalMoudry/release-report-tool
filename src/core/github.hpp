#ifndef _GITHUB_H_
#define _GITHUB_H_

#include "repository.hpp"
#include <vector>

namespace GitHub {

// A class responsible for fetching data from GitHub's API.
class GitHubDataFetcher : public Repository::IDataProvider {
public:
  virtual std::vector<Repository::ReleaseData> get_release_data(
    const Config::Config& cfg
  ) const;
};

}

#endif
