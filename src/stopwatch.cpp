#include "stopwatch.hpp"

void Stopwatch::Start() noexcept {
  m_start = std::chrono::system_clock::now();
  m_is_start_set = true;
}

void Stopwatch::Stop() noexcept {
  m_end = std::chrono::system_clock::now();
}

std::chrono::duration<double> Stopwatch::Elapsed() {
  return m_end.has_value() && m_is_start_set
    ? m_end.value() - m_start
    : std::chrono::duration<double>::zero();
}

Stopwatch Stopwatch::StartNew() noexcept {
  Stopwatch sw {};
  sw.Start();
  return sw;
}
