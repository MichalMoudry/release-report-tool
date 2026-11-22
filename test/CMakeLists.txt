add_executable(ReleaseReportToolTests)
target_sources(ReleaseReportToolTests
  PRIVATE
    ../src/report.cpp
    ../src/config/cmd_args.cpp
    cmd_args_tests.cpp
    tests.cpp
)

function(RrtTest op)
  add_test(NAME ${op} COMMAND ReleaseReportToolTests ${op})
endfunction()

RrtTest(cmd_arg_parse_happy)
RrtTest(test_args_parsing_with_zero_arg_count)
