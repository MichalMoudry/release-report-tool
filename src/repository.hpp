#ifndef _REPOSITORY_H_
#define _REPOSITORY_H_

#include <string>

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
}

#endif
