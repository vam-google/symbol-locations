#include "pybind11/pybind11.h"
#include "pybind_first.h"
#include "pybind_second.h"

PYBIND11_MODULE(libbinary_pybind_pyext, m) {
    m.doc() = "pybind11 example plugin"; // optional module docstring
    m.def("pybind_first", &pybind_first, "The first function");
    m.def("pybind_second", &pybind_second, "The second function");
}