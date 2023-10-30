load("//pybind:pywrap.bzl", "pywrap_library", "pywrap_common_library")

config_setting(
    name = "windows",
    values = {"cpu": "x64_windows"},
    visibility = ["//visibility:public"],
)

cc_library(
    name = "cc_library_second",
    hdrs = ["cc_library_second.h"],
    srcs = ["cc_library_second.cc"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "cc_library_first",
    hdrs = ["cc_library_first.h"],
    srcs = ["cc_library_first.cc"],
    deps = [":cc_library_second"],
    features = ["windows_export_all_symbols"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "cc_library_pybind",
    srcs = ["cc_library_pybind.cc"],
    features = ["windows_export_all_symbols"],
    deps = [
        ":cc_library_first",
        "@pybind11//:pybind11"
    ],
    linkstatic = False,
    alwayslink = True,
)

cc_library(
    name = "cc_library_pybind_copy",
    srcs = ["cc_library_pybind_copy.cc"],
    features = ["windows_export_all_symbols"],
    deps = [
        ":cc_library_first",
        "@pybind11//:pybind11"
    ],
    linkstatic = False,
    alwayslink = True,
)

pywrap_library(
    name = "pywrap",
    deps = [":cc_library_pybind"],
)

pywrap_library(
    name = "pywrap_copy",
    deps = ["cc_library_pybind_copy"],
)

pywrap_common_library(
    name = "pywrap_common",
    deps = [":cc_library_pybind", ":cc_library_pybind_copy"],
)

cc_binary(
    name = "cc_binary_pywrap_common",
    deps = [":pywrap_common"],
    linkstatic = True,
    linkshared = True,
    features = ["windows_export_all_symbols"],
    win_def_file = ":cc_binary_pywrap_common.def",
)

filegroup(
    name = "cc_binary_pywrap_common_if_lib",
    srcs = [":cc_binary_pywrap_common"],
    output_group = "interface_library",
)

cc_import(
    name = "cc_import_pywrap_common",
    interface_library = "cc_binary_pywrap_common_if_lib",
    shared_library = ":cc_binary_pywrap_common",
)


cc_binary(
    name = "cc_binary_pybind",
    srcs = [],
    deps = [":pywrap", "@pybind11//:pybind11", ":cc_import_pywrap_common"],
    linkstatic = True,
    linkshared = True,
    win_def_file = ":cc_binary_pybind.def",
)

cc_binary(
    name = "cc_binary_pybind_copy",
    srcs = [],
    deps = [":pywrap_copy", "@pybind11//:pybind11", ":cc_import_pywrap_common"],
    linkstatic = True,
    linkshared = True,
    win_def_file = ":cc_binary_pybind_copy.def",
)


genrule(
    name = "cc_binary_pybind_pyd",
    srcs = [":cc_binary_pybind"],
    outs = ["cc_binary_pybind.pyd"],
    cmd = "cp $< $@;",
)

genrule(
    name = "cc_binary_pybind_so",
    srcs = [":cc_binary_pybind"],
    outs = ["cc_binary_pybind.so"],
    cmd = "cp $< $@",
)

genrule(
    name = "cc_binary_pybind_copy_pyd",
    srcs = [":cc_binary_pybind_copy"],
    outs = ["cc_binary_pybind_copy.pyd"],
    cmd = "cp $< $@;",
)

genrule(
    name = "cc_binary_pybind_copy_so",
    srcs = [":cc_binary_pybind_copy"],
    outs = ["cc_binary_pybind_copy.so"],
    cmd = "cp $< $@",
)

py_test(
    name = "py_test_pybind_test",
    srcs = ["py_test_pybind_test.py"],
    data = select({
       "//pybind:windows": [
           "cc_binary_pybind.pyd",
           ":cc_binary_pybind",
           "cc_binary_pybind_copy.pyd",
           ":cc_binary_pybind_copy",
       ],
       "//conditions:default": [
           "cc_binary_pybind.so",
           "cc_binary_pybind",
           "cc_binary_pybind_copy.so",
           "cc_binary_pybind_copy",
       ],
    }),
)








