load("//rules_pywrap:pywrap.bzl", "pywrap_library")

pywrap_library(
    name = "pywrap_external_aggregated",
    # Should be generated in final version
    win_def_file = "//pybind:pybind_aggregated.def",
    py_cc_win_def_file = "//pybind:py_cc_pybind_aggregated.def",
    deps = [
        "//pybind:pybind",
        "//pybind:pybind_copy",
        "//pybind:pybind_cc_only",
    ],
    py_cc_deps = [
        "//pybind:fifth_library"
    ],

    visibility = ["//visibility:public"],
)