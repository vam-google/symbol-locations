#include "pybind11/pybind11.h"
#include "pybind/cc_library_first.h"
#include "pybind/cc_library_second.h"

PYBIND11_MODULE(cc_binary_pybind, m) {
    m.doc() = "pybind11 example plugin"; // optional module docstring
    m.def("pybind_first", &pybind_first, "The first function");
    m.def("pybind_second", &pybind_second, "The second function");
}