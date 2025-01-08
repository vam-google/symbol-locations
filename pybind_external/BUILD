load("//rules_pywrap:pywrap.bzl", "pywrap_library", "pywrap_common_library")

pywrap_library(
    name = "pybind_external_aggregated",
    # Should be generated in final version
    win_def_file = "//pybind:pybind_aggregated.def",
    deps = [
        "//pybind:pybind",
        "//pybind:pybind_copy",
        "//pybind:pybind_cc_only",
    ],
    pywrap_lib_filter = "//pybind:third_library",
)

pywrap_common_library(
    name = "pybind_external_aggregated_internal",
    dep = ":pybind_external_aggregated",
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
)

py_test(
    name = "pywrap_external_aggregated_binaries_test",
    srcs = ["pywrap_external_aggregated_binaries_test.py"],
    args = [
        "--wheel-locations=$(location {})".format(
            "//pywrap_external:pywrap_external_aggregated_binaries.json"
        ),
    ],
    data = [
        "//pywrap_external:pywrap_external_aggregated_binaries",
        "//pywrap_external:pywrap_external_aggregated_binaries.json"
    ]
)

py_binary(
    name = "pybind_external_py_binary",
    srcs = ["pybind_external_py_test.py"],
    main = "pybind_external_py_test.py",
    deps = [
        ":pybind_external_aggregated",
    ],
)

py_binary(
    name = "pybind_pywrap_external_py_binary",
    srcs = ["pybind_external_py_test.py"],
    main = "pybind_external_py_test.py",
    deps = [
        "//pywrap_external:pywrap_external_aggregated",
    ],
)