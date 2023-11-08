load("//:pywrap.bzl", "pybind_extension", "pywrap_library", "pywrap_split_library")

#
# Logic shared between python and regular C++ binaries/test
#
cc_library(
    name = "second_library",
    srcs = ["second_library.cc"],
    hdrs = ["second_library.h"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "first_library",
    srcs = ["first_library.cc"],
    hdrs = ["first_library.h"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    deps = [":second_library"],
    alwayslink = False,
)

#
# Regular C++ binaries/tests
#
cc_library(
    name = "regular",
    srcs = ["regular.cc"],
    hdrs = ["regular.h"],
    features = ["windows_export_all_symbols"],
    linkstatic = True,
    deps = [
        ":first_library",
        ":second_library",
    ],
    alwayslink = True,
)

cc_library(
    name = "regular_copy",
    srcs = ["regular_copy.cc"],
    hdrs = ["regular_copy.h"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    deps = [
        ":first_library",
        ":second_library",
    ],
    alwayslink = False,
)

# Nodes in transitive closure of this binary:
cc_test(
    name = "regular_cc_test",
    srcs = ["regular_test.cc"],
    deps = [
        ":regular",
        ":regular_copy",
        "@gtest//:gtest_main",
    ],
    #    linkstatic = by default will be "True" on windows else "False"
    #    linkstatic = False,
)

#
# Python-specific (pybind) binaries/tests
#
pybind_extension(
    name = "pybind",
    srcs = ["pybind.cc"],
    deps = [
        ":first_library",
        ":second_library",
    ],
)

pybind_extension(
    name = "pybind_copy",
    srcs = ["pybind_copy.cc"],
    deps = [
        ":first_library",
        ":second_library",
    ],
)

pywrap_library(
    name = "pybind_py_test_extension",
    # Should be generated in final version
    win_def_file = ":pybind_py_test_extension.def",
    deps = [
        ":pybind",
        ":pybind_copy",
    ],
    #    generate_common_lib = False,
)

py_test(
    name = "pybind_py_test",
    srcs = ["pybind_py_test.py"],
    deps = [":pybind_py_test_extension"],
)
