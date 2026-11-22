#ifndef _CMD_ARGS_TESTS_H_
#define _CMD_ARGS_TESTS_H_

// A test that checks if a valid set of arguments is correctly parsed.
int test_correct_args_parsing() noexcept;

// A test that checks how arguments are parsed when somehow the arg count
// argument is zero.
int test_args_parsing_with_zero_arg_count() noexcept;

#endif
