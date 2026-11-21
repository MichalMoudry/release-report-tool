#include "httplib.h"

#include <algorithm>
#include <map>
#include <string>

namespace Http {
void get(std::string url, const std::map<std::string, std::string>& headers) {
  httplib::Headers req_headers {};
  std::transform(
    headers.begin(),
    headers.end(),
    req_headers.begin(),
    [](const auto &item) { return item; }
  );

  httplib::Client client {url};
  client.set_default_headers(req_headers);
}
}
