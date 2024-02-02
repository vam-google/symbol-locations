#include "first_library.h"
#include "second_library.h"
#include "third_library.h"
#include "pybind11/pybind11.h"

PYBIND11_MODULE(pybind_copy, m) {
    m.doc() = "pybind11 example plugin";
    m.def("first_func", &first_func, "The first function");
    m.def("second_func", &second_func, "The second function");
    m.def("third_func", &third_func, "The third function");
}