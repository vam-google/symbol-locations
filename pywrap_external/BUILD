load("//:pywrap.bzl", "pywrap_library")

pywrap_library(
    name = "pywrap_external_aggregated",
    # Should be generated in final version
    win_def_file = ":pywrap_external_aggregated.def",
    deps = [
        "//pybind:pybind",
        "//pybind:pybind_copy",
    ],
    pywrap_count = 2,
    visibility = ["//visibility:public"],
)