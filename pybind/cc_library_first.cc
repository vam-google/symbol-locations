#include "pybind/cc_library_first.h"
#include "pybind/cc_library_second.h"

int pybind_first(int x) {
  return pybind_second(x) +  1;
}
