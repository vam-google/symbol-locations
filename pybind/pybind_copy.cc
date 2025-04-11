#include "first_library.h"
#include "second_library.h"
#include "third_library.h"
#include "pybind11/pybind11.h"
//#include "nanobind/nanobind.h"

namespace bindings = pybind11;
//namespace bindings = nanobind;

PYBIND11_MODULE(pybind_copy, m) {
//NB_MODULE(pybind_copy, m) {
  m.doc() = "pybind11 example plugin";
  m.def("first_func", &first_func, "The first function");
  m.def("second_func", &second_func, "The second function");
  m.def("third_func", &third_func, "The third function");
  m.def("second_global_func", &second_global_func, "The second_global function");
  m.attr("_EXTRA_SYMBOL") = bindings::int_(123);

  auto subM = m.def_submodule("sub", "submodule");
  subM.def("second_func", &second_func, "");

  bindings::enum_<SharedEnum>(subM, "PybindEnum", bindings::module_local())
    .value("SHARED_VAL", SHARED_VAL)
    .value("SHARED_VAL_COPY", SHARED_VAL_COPY);

  bindings::class_<SharedClass>(subM, "SharedClass", bindings::module_local())
      .def(bindings::init<>())
      .def("foo", &SharedClass::foo);
}