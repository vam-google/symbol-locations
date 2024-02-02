#include "third_library.h"

// This is similar to my_pybind_global from second_library.cc, but in reverse -
// we want it to be statically copied into each dynamic library. This is to test
// `alwayslink_deps` argument of pybind_library. This is undesirable behavior in
// almost all cases, but there are a few libraries which are designed to be
// statically linked in pywraps, so we need to support this feature.
static int my_pybind_global_copy = 0;

int third_func(int x) {
  return x + my_pybind_global_copy++;
}