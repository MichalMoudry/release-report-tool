cmake_minimum_required(VERSION 3.23)
project(ReleaseReportTool)
set (CMAKE_CXX_STANDARD 23)
set (CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(FetchContent)
FetchContent_Declare(
  json URL https://github.com/nlohmann/json/releases/download/v3.12.0/json.tar.xz
)
FetchContent_Declare(
  httplib URL https://github.com/yhirose/cpp-httplib/archive/refs/tags/v0.66.0.tar.gz
)
FetchContent_MakeAvailable(json httplib)

add_executable(rrt)
target_sources(rrt
    PRIVATE
        src/main.cpp
        src/client.cpp
        src/config/cmd_args.cpp
        src/config/config.cpp
        src/repository/repository.cpp
        src/repository/github.cpp
)
target_link_libraries(rrt PRIVATE nlohmann_json::nlohmann_json httplib)

if(
  (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC") OR
  (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
)
  target_compile_options(rrt PRIVATE /W3)
elseif(
  (CMAKE_CXX_COMPILER_ID STREQUAL "GNU") OR
  (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
)
  target_compile_options(rrt PRIVATE -xc++ -Wall)
endif()
