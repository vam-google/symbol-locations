config_setting(
    name = "windows",
    values = {"cpu": "x64_windows"},
    visibility = ["//visibility:public"],
)

test_suite(
    name = "all_tests",
    tests = [
        "//pybind:regular_cc_test",
        "//pybind:pybind_py_test",
        "//pybind:pybind_with_starlark_only_py_test",
        "//pybind:common_library_test",
        "//pybind:py_common_library_test",
        "//pybind_external:pybind_external_py_test",
        "//pybind_external:pybind_pywrap_external_py_test",
        "//pybind_external:pywrap_external_aggregated_binaries_test",
        "//proto:proto_test",
        "//absl:absl_test",
    ],
)