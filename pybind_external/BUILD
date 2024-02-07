load("//rules_pywrap:pywrap.bzl", "pywrap_library")

pywrap_library(
    name = "pybind_external_aggregated",
    # Should be generated in final version
    win_def_file = ":pybind_external_aggregated.def",
    deps = [
        "//pybind:pybind",
        "//pybind:pybind_copy",
    ],
    pywrap_count = 2,
)

py_test(
    name = "pybind_external_py_test",
    srcs = ["pybind_external_py_test.py"],
    deps = [
        ":pybind_external_aggregated",
    ],
)

py_test(
    name = "pybind_pywrap_external_py_test",
    srcs = ["pybind_external_py_test.py"],
    main = "pybind_external_py_test.py",
    deps = [
        "//pywrap_external:pywrap_external_aggregated",
    ],
    env = {
        "PYWRAP_TARGET": "//pywrap_external:pywrap_external_aggregated"
    }
)

py_binary(
    name = "pybind_external_py_binary",
    srcs = ["pybind_external_py_test.py"],
    main = "pybind_external_py_test.py",
    deps = [
        ":pybind_external_aggregated",
    ],
)