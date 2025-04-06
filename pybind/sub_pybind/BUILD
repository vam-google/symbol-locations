load("//rules_pywrap:pywrap.bzl", "pybind_extension")

pybind_extension(
    name = "nested_pybind",
    srcs = ["nested_pybind.cc"],
    common_lib_packages = [
        "",
        "pywrap_external/python",  # non-existent package to test that its Ok
        "pybind",
        "pybind_external",
        "pywrap_external",
    ],
#    visibility = ["//visibility:public"],
    deps = [
        "//pybind:fifth_library",
    ],
)

py_library(
    name = "relative_import_lib",
    srcs = ["relative_import_lib.py"],
    deps = [
        ":nested_pybind",
    ],
    visibility = ["//visibility:public"]
)