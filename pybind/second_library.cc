#include "second_library.h"

int second_global = 0;

// If linked mistakenly two or more times in different dynamic libraries the
// test will fail. This imitates protobuf behavior in terms of linkage in its
// most primitive approximation.
static int my_pybind_global = 0;

int second_func(int x) {
  return x + my_pybind_global++;
}

int second_global_func() {
  return second_global;
}