load("//rules_pywrap:pywrap.bzl",
    "pybind_extension",
    "pywrap_library",
    "pywrap_common_library",
    "pywrap_binaries",
)
#load("//:pywrap_repositories.bzl", "py_test")
exports_files(["pybind_aggregated.def", "py_cc_pybind_aggregated.def"])


#
# Logic shared between python and regular C++ binaries/test
#
cc_library(
    name = "sixth_library",
    hdrs = ["sixth_library.h"],
    srcs = ["sixth_library.cc"],
    deps = [":second_library"],
    features = ["windows_export_all_symbols"],
    linkstatic = True,
    alwayslink = False,
    visibility = ["//visibility:public"],
)

cc_library(
    name = "fifth_library",
    hdrs = ["fifth_library.h"],
    srcs = ["fifth_library.cc"],
    deps = [":second_library"],
    features = ["windows_export_all_symbols"],
    linkstatic = True,
    alwayslink = False,
    visibility = ["//visibility:public"],
)

cc_library(
    name = "fourth_library",
    srcs = ["fourth_library.cc"],
    deps = [":second_library"],
    features = ["windows_export_all_symbols"],
    linkstatic = True,
    alwayslink = False,
)

cc_library(
    name = "third_library",
    srcs = ["third_library.cc"],
    hdrs = ["third_library.h"],
#    deps = [":second_library"],
    features = ["windows_export_all_symbols"],
    linkstatic = True,
    alwayslink = False,
    visibility = ["//visibility:public"],
)

cc_library(
    name = "second_library",
    srcs = ["second_library.cc"],
    hdrs = ["second_library.h"],
    features = ["windows_export_all_symbols"],
    linkstatic = True,
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
        ":fifth_library",
        ":third_library",
    ],
    additional_exported_symbols = [
        "_EXTRA_SYMBOL"
    ],
    common_lib_packages = [
        "",
        "pywrap_external/python",  # non-existent package to test that its Ok
        "pybind_external",
        "pywrap_external",
    ],
    visibility = ["//visibility:public"],
)

pybind_extension(
    name = "pybind_copy",
    srcs = ["pybind_copy.cc"],
    deps = [
        ":first_library",
        ":second_library",
        ":third_library",
    ],
    additional_exported_symbols = [
        "_EXTRA_SYMBOL"
    ],
    common_lib_packages = ["", "pywrap_external", "pybind_external"],
    visibility = ["//visibility:public"],
)

pybind_extension(
    name = "pybind_cc_only",
    deps = [
        "fourth_library",
    ],
    visibility = ["//visibility:public"],
)

pybind_extension(
    name = "pybind_with_starlark_only",
    srcs = ["pybind_with_starlark_only.cc"],
    deps = [
        ":sixth_library",
    ],
    common_lib_packages = ["", "pywrap_external", "pybind_external"],
    starlark_only = True,
    visibility = ["//visibility:public"],
)

py_library(
    name = "py_library_1",
    srcs = [],
    deps = [":pybind"],
)


py_library(
    name = "py_library_2",
    srcs = [],
    # "pybind" is already in py_library1, duplicats "pybind" on purpose
    # to test that it is ok
    deps = [":py_library_3", ":pybind"],
)

py_library(
    name = "py_library_3",
    srcs = [],
    # The only place where pybind_copy is provided, and it will be consumed by
    # pybind_aggregated only as a multi-level transitive dependency.
    deps = [":pybind_copy"],
)

py_library(
    name = "py_library_4",
    srcs = [],
    deps = [":pybind_cc_only"],
)


pywrap_library(
    name = "pybind_aggregated",
    # Should be generated in final version
    win_def_file = ":pybind_aggregated.def",
    deps = [
        ":pybind_with_starlark_only",
        ":py_library_1",
        ":py_library_2",
        ":py_library_3",
        ":py_library_4",
    ],
    common_lib_filters = {
        "libframework.so.2": ":fifth_library",
    },
    common_lib_version_scripts = {
        "libframework.so.2": "//pybind:framework.lds",
    },
    pywrap_lib_filter = ":third_library",
    pywrap_count = 3,
    starlark_only_pywrap_count = 1,
    visibility = ["//visibility:public"],
)

pywrap_common_library(
    name = "common_pybind_aggregated_internal",
    dep = ":pybind_aggregated"
)

pywrap_common_library(
    name = "common_pybind_aggregated_framework",
    dep = ":pybind_aggregated",
    filter_name = "libframework.so.2"
)

pywrap_binaries(
    name = "pybind_aggregated_binaries",
    dep = ":pybind_aggregated",
)

py_test(
    name = "pybind_py_test",
    srcs = ["pybind_py_test.py"],
    deps = [
        ":pybind_aggregated",
        # not needed, since duplicated, but passed to check that duplication is
        # ok
        "py_library_1"
    ],
)

py_test(
    name = "pybind_with_starlark_only_py_test",
    srcs = ["pybind_with_starlark_only_py_test.py"],
    deps = [
        ":pybind_aggregated",
        # not needed, since duplicated, but passed to check that duplication is
        # ok
        "py_library_1"
    ],
)

cc_test(
    name = "common_library_test",
    srcs = [
        "common_library_test.cc",
        "first_library.h",
        "second_library.h",
    ],
    deps = [
        ":common_pybind_aggregated_framework",
        "@gtest//:gtest_main",
    ],
)

cc_test(
    name = "py_common_library_test",
    srcs = [
        "py_common_library_test.cc",
        "first_library.h",
        "second_library.h",
        "fifth_library.h",
    ],
    deps = [
        ":common_pybind_aggregated_framework",
        ":common_pybind_aggregated_internal",
        "@gtest//:gtest_main",
    ],
)
