config_setting(
    name = "windows",
    values = {"cpu": "x64_windows"},
    visibility = ["//visibility:public"],
)

cc_library(
    name = "pybind_second_00",
    hdrs = ["pybind_second.h"],
    srcs = ["pybind_second.cc"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "pybind_first_00_second_00",
    hdrs = ["pybind_first.h"],
    srcs = ["pybind_first.cc"],
    deps = [":pybind_second_00"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "pybind_pyext_first_00_first_00_second_00",
    srcs = ["pybind_pyext.cc"],
    features = ["windows_export_all_symbols"],
    deps = [
        ":pybind_first_00_second_00",
        "@pybind11//:pybind11"
    ],
    linkstatic = False,
    alwayslink = False,
)

cc_binary(
    name = "binary_pybind_pyext",
    deps = [":pybind_pyext_first_00_first_00_second_00"],
    linkstatic = False,
    linkshared = True,
)

py_test(
    name = "pybind_test",
    srcs = ["pybind_test.py"],
    data = [":binary_pybind_pyext"]
)
