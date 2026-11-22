#ifndef _JSON_H_
#define _JSON_H_

#include <memory>

#include "config/config.hpp"
#include "nlohmann/json_fwd.hpp"

namespace Json {

// Uses JSON values as config values from a provided parsed JSON object.
std::unique_ptr<Config::Config> config_from_json(
  const nlohmann::json& json
) noexcept;

}

#endif
