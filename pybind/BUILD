load("//pybind:pywrap.bzl", "pywrap_library", "pywrap_common_library")

config_setting(
    name = "windows",
    values = {"cpu": "x64_windows"},
    visibility = ["//visibility:public"],
)

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

cc_library(
    name = "pybind",
    srcs = ["pybind.cc"],
    features = ["windows_export_all_symbols"],
    deps = [
        ":first_library",
        "@pybind11//:pybind11"
    ],
    linkstatic = False,
    alwayslink = True,  # MUST be True
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
    alwayslink = True, # MUST be True
)

#
# pywrap common library
#
pywrap_common_library(
    name = "pybind_and_pybind_copy_pywrap_common",
    deps = [":pybind", ":pybind_copy"],
)

cc_binary(
    name = "pybind_and_pybind_copy_pywrap_common_cc_binary",
    deps = [":pybind_and_pybind_copy_pywrap_common"],
    linkstatic = True,
    linkshared = True,
    features = ["windows_export_all_symbols"],
    win_def_file = ":pybind_and_pybind_copy_pywrap_common_cc_binary.def",
)

filegroup(
    name = "pybind_and_pybind_copy_pywrap_common_if_lib",
    srcs = [":pybind_and_pybind_copy_pywrap_common_cc_binary"],
    output_group = "interface_library",
)

cc_import(
    name = "pybind_and_pybind_copy_pywrap_common_import",
    interface_library = "pybind_and_pybind_copy_pywrap_common_if_lib",
    shared_library = ":pybind_and_pybind_copy_pywrap_common_cc_binary",
)

#
# individual pywrap libraries
#

# first lib
pywrap_library(
    name = "pybind_pywrap",
    deps = [":pybind"],
)

cc_binary(
    name = "pybind_cc_binary",
    srcs = [],
    deps = [
        ":pybind_pywrap",
        "@pybind11//:pybind11",
        ":pybind_and_pybind_copy_pywrap_common_import"
    ],
    linkstatic = True,
    linkshared = True,
    win_def_file = ":pybind_cc_binary.def",
)


genrule(
    name = "pybind_cc_binary_pyd",
    srcs = [":pybind_cc_binary"],
    outs = ["pybind_cc_binary.pyd"],
    cmd = "cp $< $@;",
)

genrule(
    name = "pybind_cc_binary_so",
    srcs = [":pybind_cc_binary"],
    outs = ["pybind_cc_binary.so"],
    cmd = "cp $< $@",
)

# second library
pywrap_library(
    name = "pybind_copy_pywrap",
    deps = ["pybind_copy"],
)

cc_binary(
    name = "pybind_copy_cc_binary",
    srcs = [],
    deps = [
        ":pybind_copy_pywrap",
        "@pybind11//:pybind11",
        ":pybind_and_pybind_copy_pywrap_common_import"
    ],
    linkstatic = True,
    linkshared = True,
    win_def_file = ":pybind_copy_cc_binary.def",
)

genrule(
    name = "pybind_copy_cc_binary_pyd",
    srcs = [":pybind_copy_cc_binary"],
    outs = ["pybind_copy_cc_binary.pyd"],
    cmd = "cp $< $@;",
)

genrule(
    name = "cc_binary_pybind_copy_so",
    srcs = [":pybind_copy_cc_binary"],
    outs = ["pybind_copy_cc_binary.so"],
    cmd = "cp $< $@",
)


#
# Test
#
py_test(
    name = "pybind_py_test",
    srcs = ["pybind_py_test.py"],
    data = select({
       "//pybind:windows": [
           "pybind_cc_binary.pyd",
           ":pybind_cc_binary",
           "pybind_copy_cc_binary.pyd",
           ":pybind_copy_cc_binary",
       ],
       "//conditions:default": [
           "pybind_cc_binary.so",
           "pybind_cc_binary",
           "pybind_copy_cc_binary.so",
           "pybind_copy_cc_binary",
       ],
    }),
)








