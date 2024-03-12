#include "first_library.h"
#include "second_library.h"
#include "third_library.h"
#include "pybind11/pybind11.h"
#include "fifth_library.h"

PYBIND11_MODULE(pybind, m) {
  fifth_func(); // needed to  make sure the dynamic library is loaded on Windows
  m.doc() = "pybind11 example plugin";
  m.def("first_func", &first_func, "The first function");
  m.def("second_func", &second_func, "The second function");
  m.def("third_func", &third_func, "The third function");
  m.def("second_global_func", &second_global_func, "The second_global function");
  m.attr("_EXTRA_SYMBOL") = pybind11::int_(123);
}