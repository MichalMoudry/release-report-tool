add_executable(ReleaseReportToolTests)
target_sources(ReleaseReportToolTests
  PRIVATE
    tests.cpp
    ../src/config/cmd_args.cpp
)

function(RrtTest op)
  add_test(NAME ${op} COMMAND ReleaseReportToolTests ${op})
endfunction()

RrtTest(cmd_arg_parse_happy)
