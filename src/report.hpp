#ifndef _REPORT_H_
#define _REPORT_H_

#include <iostream>

namespace Report {
enum struct Format { Unknown = 0, Console = 1, Html = 2 };
enum struct Result { Undetermined = 0, Success = 1, Failure = 2 };

std::ostream& operator<<(std::ostream& os, Format format) noexcept;
}

#endif
