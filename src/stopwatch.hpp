#ifndef _STOPWATCH_H_
#define _STOPWATCH_H_

#include <chrono>
#include <optional>

// A class that keeps a track of time between two time points.
class Stopwatch final {
private:
  std::optional<std::chrono::time_point<std::chrono::system_clock>> m_end;
  std::chrono::time_point<std::chrono::system_clock> m_start;
  bool m_is_start_set;

public:
  // Starts the stopwatch.
  void Start() noexcept;
  // Stops stopwatch's time measuring.
  void Stop() noexcept;
  // A span of time that's elapsed between start and stop operations.
  std::chrono::duration<double> Elapsed();

  // A helper function to initialise the {!Stopwatch} that's already running.
  static Stopwatch StartNew() noexcept;
};

#endif
