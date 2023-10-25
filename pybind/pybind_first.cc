#include "pybind_first.h"
#include "pybind_second.h"

int pybind_first(int x) {
  return pybind_second(x) +  1;
}
