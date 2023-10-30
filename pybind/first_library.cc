#include "pybind/first_library.h"
#include "pybind/second_library.h"

int pybind_first(int x) {
  return pybind_second(x) +  1;
}
