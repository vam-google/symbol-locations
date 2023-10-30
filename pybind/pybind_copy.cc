#include "pybind11/pybind11.h"
#include "pybind/first_library.h"
#include "pybind/second_library.h"

PYBIND11_MODULE(pybind_copy_cc_binary, m) {
    m.doc() = "pybind11 example plugin"; // optional module docstring
    m.def("pybind_first", &pybind_first, "The first function");
    m.def("pybind_second", &pybind_second, "The second function");
}