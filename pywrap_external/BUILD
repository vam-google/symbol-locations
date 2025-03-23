load("//rules_pywrap:pywrap.bzl", "pywrap_binaries", "pywrap_library")

pywrap_library(
    name = "pywrap_external_aggregated",
    common_lib_filters = {
        "pybind/libframework": "//pybind:fifth_library",
    },
    common_lib_versions = {
        "pybind/libframework": "2",
    },
    pywrap_lib_filter = "//pybind:third_library",
    starlark_only_deps = [
        "//pybind:pybind_with_starlark_only",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//pybind",
        "//pybind:pybind_cc_only",
        "//pybind:pybind_copy",
    ],
)

pywrap_binaries(
    name = "pywrap_external_aggregated_binaries",
    dep = ":pywrap_external_aggregated",
    visibility = ["//visibility:public"],
)
