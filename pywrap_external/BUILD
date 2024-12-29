load("//rules_pywrap:pywrap.bzl", "pywrap_library", "pywrap_binaries")

pywrap_library(
    name = "pywrap_external_aggregated",
    # Should be generated in final version
    win_def_file = "//pybind:pybind_aggregated.def",
    deps = [
        "//pybind:pybind_with_starlark_only",
        "//pybind:pybind",
        "//pybind:pybind_copy",
        "//pybind:pybind_cc_only",
    ],
    common_lib_filters = {
        "//pybind:fifth_library": "pybind/libframework.so.2",
    },
    pywrap_count = 3,
    starlark_only_pywrap_count = 1,
    pywrap_lib_filter = "//pybind:third_library",
    visibility = ["//visibility:public"],
)

pywrap_binaries(
    name = "pywrap_external_aggregated_binaries",
    dep = ":pywrap_external_aggregated",
    visibility = ["//visibility:public"],
)
