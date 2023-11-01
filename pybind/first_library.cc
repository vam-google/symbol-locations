#include "pybind/first_library.h"
#include "pybind/second_library.h"

int first_func(int x) {
  return second_func(x) +  1;
}
