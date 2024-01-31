config_setting(
    name = "windows",
    values = {"cpu": "x64_windows"},
    visibility = ["//visibility:public"],
)

test_suite(
    name = "all_tests",
    tests = [
        "//pybind_downstream:pybind_downstream_py_test",
        "//pybind_downstream:pybind_downstream_pywrap_external_py_test",
        "@symbol_locations//pybind:pybind_py_test",
        "@symbol_locations//pybind_external:pybind_external_py_test",
        "@symbol_locations//pybind_external:pybind_pywrap_external_py_test",
    ]
)