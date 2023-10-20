#include "pybind/pybind_second.h"

static int my_pybind_global = 0;

int pybind_second(int x) {
  return x + my_pybind_global++;;
}