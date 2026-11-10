cmake_minimum_required(VERSION 3.23)
project(ReleaseReportTool)
set (CMAKE_CXX_STANDARD 23)
set (CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(rrt)
target_sources(rrt
    PRIVATE
        src/main.cpp
        src/cmd_args.cpp
        src/config.cpp
)

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
