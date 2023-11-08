load("//:pywrap.bzl", "pybind_extension", "pywrap_extension", "pywrap_split_library")

#
# Logic shared between python and regular C++ binaries/test
#
cc_library(
    name = "second_library",
    hdrs = ["second_library.h"],
    srcs = ["second_library.cc"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "first_library",
    hdrs = ["first_library.h"],
    srcs = ["first_library.cc"],
    deps = [":second_library"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    alwayslink = False,
)


#
# Regular C++ binaries/tests
#
cc_library(
    name = "regular",
    hdrs = ["regular.h"],
    srcs = ["regular.cc"],
    deps = [
        ":first_library",
        ":second_library",
    ],
    features = ["windows_export_all_symbols"],
    linkstatic = True,
    alwayslink = True,
)

cc_library(
    name = "regular_copy",
    hdrs = ["regular_copy.h"],
    srcs = ["regular_copy.cc"],
    deps = [
        ":first_library",
        ":second_library",
    ],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    alwayslink = False,
)

# Nodes in transitive closure of this binary:
cc_test(
    name = "regular_cc_test",
    srcs = ["regular_test.cc"],
    deps = [
        ":regular",
        ":regular_copy",
        "@gtest//:gtest_main"
    ],
#    linkstatic = by default will be "True" on windows else "False"
#    linkstatic = False,
)

#
# Python-specific (pybind) binaries/tests
#
pybind_extension(
    name = "pybind_cc_binary",
    srcs = ["pybind.cc"],
    deps = [
        ":first_library",
        ":second_library",
    ],
)

pybind_extension(
    name = "pybind_copy_cc_binary",
    srcs = ["pybind_copy.cc"],
    deps = [
        ":first_library",
        ":second_library",
    ],
)

pywrap_extension(
    name = "pybind_py_test_extension",
    deps = [
        ":pybind_cc_binary",
        ":pybind_copy_cc_binary"
    ],
    # Should be generated in final version
    win_def_file = ":pybind_py_test_extension.def",
#    generate_common_lib = False,
)

py_test(
    name = "pybind_py_test",
    srcs = ["pybind_py_test.py"],
    deps = [":pybind_py_test_extension"],
)


