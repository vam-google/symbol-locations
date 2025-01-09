load("//rules_pywrap:pywrap.bzl", "pywrap_library", "pywrap_binaries")

pywrap_library(
    name = "pywrap_external_aggregated",
    # Should be generated in final version
    win_def_file = "//pybind:pybind_aggregated.def",
    deps = [
        "//pybind:pybind",
        "//pybind:pybind_copy",
        "//pybind:pybind_cc_only",
    ],
    common_lib_filters = {
        "pybind/libframework.so.2": "//pybind:fifth_library",
    },
    starlark_only_deps = [
        "//pybind:pybind_with_starlark_only",
    ],
    pywrap_lib_filter = "//pybind:third_library",
    visibility = ["//visibility:public"],
)

pywrap_binaries(
    name = "pywrap_external_aggregated_binaries",
    dep = ":pywrap_external_aggregated",
    visibility = ["//visibility:public"],
)
