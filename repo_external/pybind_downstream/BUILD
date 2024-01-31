load("@symbol_locations//:pywrap.bzl", "pybind_extension", "pywrap_library")

pywrap_library(
    name = "pybind_downstream_aggregated",
    # Should be generated in final version
    win_def_file = ":pybind_downstream_aggregated.def",
    deps = [
        "@symbol_locations//pybind:pybind",
        "@symbol_locations//pybind:pybind_copy",
    ],
    pywrap_count = 2,
)


py_test(
    name = "pybind_downstream_py_test",
    srcs = ["pybind_downstream_py_test.py"],
    deps = [
        ":pybind_downstream_aggregated",
    ],
)

py_test(
    name = "pybind_downstream_pywrap_external_py_test",
    srcs = ["pybind_downstream_py_test.py"],
    main = "pybind_downstream_py_test.py",
    deps = [
        "@symbol_locations//pywrap_external:pywrap_external_aggregated",
    ],
    env = {
        "PYWRAP_TARGET": "@symbol_locations//pywrap_external:pywrap_external_aggregated"
    }
)