#include "report.hpp"
#include "repository.hpp"

#include <memory>

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
  const Repository::IDataProvider& data_provider,
  Format fmt,
  std::unique_ptr<Config::Config> cfg) {
  if (!st.stop_requested()) {
    /*switch (repo_type) {
      case Repository::GitHub:
        GitHub::GitHubDataFetcher{}.get_release_data(*cfg);
        break;
      case Repository::Unknown:
        promise.set_value(Report::Result::Undetermined);
        break;
    }*/
    auto release_data {data_provider.get_release_data(*cfg)};
  }
}

}
