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
    local_defines = ["TARGET_NAME=nested_pybind"],
)

py_library(
    name = "relative_import_lib",
    srcs = ["relative_import_lib.py"],
    deps = [
        ":nested_pybind",
    ],
    visibility = ["//visibility:public"]
)

pybind_extension(
    name = "nested_wrapped_pybind",
    srcs = ["nested_pybind.cc"],
    common_lib_packages = [
        "",
        "pybind",
    ],
    deps = [
        "//pybind:fifth_library",
    ],
    wrap_py_init = True,
    local_defines = ["TARGET_NAME=nested_wrapped_pybind"],
)

py_library(
    name = "relative_wrapped_import_lib",
    srcs = ["relative_wrapped_import_lib.py"],
    deps = [
        ":nested_wrapped_pybind",
    ],
    visibility = ["//visibility:public"]
)