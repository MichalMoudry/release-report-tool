#ifndef _REPORT_H_
#define _REPORT_H_

#include "../config/config.hpp"
#include "repository.hpp"
#include <future>
#include <iostream>
#include <memory>
#include <stop_token>

namespace Report {

enum struct Format { Unknown = 0, Console = 1 };
enum struct Result { Undetermined = 0, Success = 1, Failure = 2 };

std::ostream& operator<<(std::ostream& os, Format format) noexcept;

void generate(
  std::stop_token st,
  std::promise<Result>& promise,
  Repository::Type repo_type,
  Format fmt,
  std::unique_ptr<Config::Config> cfg
);

}

#endif
