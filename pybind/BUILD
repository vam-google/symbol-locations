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
    deps = [":pybind_pyext_first_00_first_00_second_00", ":pybind_pyext.lds"],
    linkstatic = False,
    linkshared = True,
    win_def_file = ":pybind_pyext.def",
#    linkopts = ["-Wl,-exported_symbols_list,$(location :pybind_pyext.lds)"],
)

cc_library(
    name = "pybind_pyext_copy_first_00_first_00_second_00",
    srcs = ["pybind_pyext_copy.cc"],
    features = ["windows_export_all_symbols"],
    deps = [
        ":pybind_first_00_second_00",
        "@pybind11//:pybind11"
    ],
    linkstatic = False,
    alwayslink = False,
)

cc_binary(
    name = "binary_pybind_pyext_copy",
    deps = [":pybind_pyext_copy_first_00_first_00_second_00", ":pybind_pyext_copy.lds"],
    linkstatic = False,
    linkshared = True,
    win_def_file = ":pybind_pyext_copy.def",
#    linkopts = ["-Wl,-exported_symbols_list,$(location :pybind_pyext_copy.lds)"],
)

genrule(
    name = "_binary_pybind_pyext_pyd",
    srcs = [":binary_pybind_pyext"],
    outs = ["binary_pybind_pyext.pyd"],
    cmd = "cp $< $@;",
)

genrule(
    name = "_binary_pybind_pyext_so",
    srcs = [":binary_pybind_pyext"],
    outs = ["binary_pybind_pyext.so"],
    cmd = "cp $< $@",
)

genrule(
    name = "_binary_pybind_pyext_copy_pyd",
    srcs = [":binary_pybind_pyext_copy"],
    outs = ["binary_pybind_pyext_copy.pyd"],
    cmd = "cp $< $@;",
)

genrule(
    name = "_binary_pybind_pyext_copy_so",
    srcs = [":binary_pybind_pyext_copy"],
    outs = ["binary_pybind_pyext_copy.so"],
    cmd = "cp $< $@",
)

py_test(
    name = "pybind_test",
    srcs = ["pybind_test.py"],
#    data = [":binary_pybind_pyext"],
    data = select({
       "//pybind:windows": [
           "binary_pybind_pyext.pyd",
           ":binary_pybind_pyext",
           "binary_pybind_pyext_copy.pyd",
           ":binary_pybind_pyext_copy",
#           ":pybind_pyext_first_00_first_00_second_00",
#           ":pybind_first_00_second_00",
#           ":pybind_second_00"
       ],
       "//conditions:default": [
           "binary_pybind_pyext.so",
           "binary_pybind_pyext",
           "binary_pybind_pyext_copy.so",
           "binary_pybind_pyext_copy",
       ],
    }),
)
