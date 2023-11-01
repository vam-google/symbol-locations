#include "pybind11/pybind11.h"
#include "pybind/first_library.h"
#include "pybind/second_library.h"

PYBIND11_MODULE(pybind_cc_binary, m) {
    m.doc() = "pybind11 example plugin"; // optional module docstring
    m.def("first_func", &first_func, "The first function");
    m.def("second_func", &second_func, "The second function");
}