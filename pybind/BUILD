load("//pybind:pywrap.bzl", "pywrap_extension", "pywrap_split_library")

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
# bazel query "deps(//pybind:regular_cc_test)" --output label_kind | grep "rule //"
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
cc_library(
    name = "pybind",
    srcs = ["pybind.cc"],
    features = ["windows_export_all_symbols"],
    deps = [
        ":first_library",
        "@pybind11//:pybind11"
    ],
    linkstatic = False,
)

cc_library(
    name = "pybind_copy",
    srcs = ["pybind_copy.cc"],
    features = ["windows_export_all_symbols"],
    deps = [
        ":first_library",
        "@pybind11//:pybind11"
    ],
    linkstatic = False,
)

pywrap_extension(
    name = "pybind_py_test_extension",
    deps = {
        ":pybind": [
            "pybind_cc_binary",
            # Should be generated in final version
            ":pybind_cc_binary.def"
        ],
        ":pybind_copy": [
            "pybind_copy_cc_binary",
            # Should be generated in final version
            ":pybind_copy_cc_binary.def"
        ],
    },
    # Should be generated in final version
    common_win_def_file = ":pybind_and_pybind_copy_pywrap_common_cc_binary.def",
)

py_test(
    name = "pybind_py_test",
    srcs = ["pybind_py_test.py"],
    deps = [":pybind_py_test_extension"],
)


##
## pywrap common library
##
#pywrap_split_library(
#    name = "pybind_and_pybind_copy_pywrap_common",
#    deps = [":pybind", ":pybind_copy"],
#    keep_deps = True,
#)
#
#cc_binary(
#    name = "pybind_and_pybind_copy_pywrap_common_cc_binary",
#    deps = [":pybind_and_pybind_copy_pywrap_common"],
#    linkstatic = True,
#    linkshared = True,
#    features = ["windows_export_all_symbols"],
#    win_def_file = ":pybind_and_pybind_copy_pywrap_common_cc_binary.def",
#)
#
#filegroup(
#    name = "pybind_and_pybind_copy_pywrap_common_if_lib",
#    srcs = [":pybind_and_pybind_copy_pywrap_common_cc_binary"],
#    output_group = "interface_library",
#)
#
#cc_import(
#    name = "pybind_and_pybind_copy_pywrap_common_import",
#    interface_library = "pybind_and_pybind_copy_pywrap_common_if_lib",
#    shared_library = ":pybind_and_pybind_copy_pywrap_common_cc_binary",
#)
#
##
## individual pywrap libraries
##
#
## first library
#pywrap_split_library(
#    name = "pybind_pywrap",
#    deps = [":pybind"],
#    keep_deps = False,
#)
#
#cc_binary(
#    name = "pybind_cc_binary",
#    srcs = [],
#    deps = [
#        ":pybind_pywrap",
#        "@pybind11//:pybind11",
#        ":pybind_and_pybind_copy_pywrap_common_import"
#    ],
#    linkstatic = True,
#    linkshared = True,
#    win_def_file = ":pybind_cc_binary.def",
#)
#
#genrule(
#    name = "pybind_cc_binary_pyd",
#    srcs = [":pybind_cc_binary"],
#    outs = ["pybind_cc_binary.pyd"],
#    cmd = "cp $< $@;",
#)
#
#genrule(
#    name = "pybind_cc_binary_so",
#    srcs = [":pybind_cc_binary"],
#    outs = ["pybind_cc_binary.so"],
#    cmd = "cp $< $@",
#)
#
## second library
#pywrap_split_library(
#    name = "pybind_copy_pywrap",
#    deps = ["pybind_copy"],
#    keep_deps = False,
#)
#
#cc_binary(
#    name = "pybind_copy_cc_binary",
#    srcs = [],
#    deps = [
#        ":pybind_copy_pywrap",
#        "@pybind11//:pybind11",
#        ":pybind_and_pybind_copy_pywrap_common_import"
#    ],
#    linkstatic = True,
#    linkshared = True,
#    win_def_file = ":pybind_copy_cc_binary.def",
#)
#
#genrule(
#    name = "pybind_copy_cc_binary_pyd",
#    srcs = [":pybind_copy_cc_binary"],
#    outs = ["pybind_copy_cc_binary.pyd"],
#    cmd = "cp $< $@;",
#)
#
#genrule(
#    name = "cc_binary_pybind_copy_so",
#    srcs = [":pybind_copy_cc_binary"],
#    outs = ["pybind_copy_cc_binary.so"],
#    cmd = "cp $< $@",
#)
#
##
## Test
##
#py_test(
#    name = "pybind_py_test",
#    srcs = ["pybind_py_test.py"],
#    deps = [":stub_library"]
##    data = select({
##       "//:windows": [
##           "pybind_cc_binary.pyd",
##           ":pybind_cc_binary",
##           "pybind_copy_cc_binary.pyd",
##           ":pybind_copy_cc_binary",
##       ],
##       "//conditions:default": [
##           "pybind_cc_binary.so",
##           "pybind_cc_binary",
##           "pybind_copy_cc_binary.so",
##           "pybind_copy_cc_binary",
##       ],
##    }),
#)
#
#py_library(
#    name = "stub_library",
#    data = [
#       "pybind_cc_binary.so",
#       "pybind_cc_binary",
#       "pybind_copy_cc_binary.so",
#       "pybind_copy_cc_binary",
#    ]
#)


