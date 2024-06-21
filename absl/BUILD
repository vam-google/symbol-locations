load("//absl:absl_check.bzl", "cc_header_only_library")

cc_library(
    name = "absl_check_cc_library",
    srcs = [
        "absl_check.cc"
    ],
    hdrs = [
        "absl_check.h",
    ],
    deps = [
        "@com_google_absl//absl/container:flat_hash_map",
    ],
    alwayslink = True,
    visibility = ["//visibility:public"],
)

#cc_library(
#    name = "absl_check_cc_library_headers",
#    hdrs = ["absl_check.h"],
#    visibility = ["//visibility:public"],
#)

cc_header_only_library(
    name = "absl_check_cc_library_headers",
    deps = [
        ":absl_check_cc_library",
    ],
)

cc_binary(
    name = "absl_check_cc_binary",
    deps = [
        ":absl_check_cc_library",
    ],
    linkshared = True,
    linkstatic = True,
    win_def_file = "absl_check.def",
)

filegroup(
    name = "absl_check_if_lib",
    srcs = ["absl_check_cc_binary"],
    output_group = "interface_library",
)

cc_import(
    name = "absl_check_cc_import",
    shared_library = "absl_check_cc_binary",
    interface_library = "absl_check_if_lib",
)

cc_test(
    name = "absl_test",
    srcs = ["absl_test.cc"],
    deps = [
        "@gtest//:gtest_main",
        ":absl_check_cc_library_headers",
        ":absl_check_cc_import",
#        "@com_google_absl//absl/container:flat_hash_map",
    ],
    local_defines = ["ABSL_CONSUME_DLL"],
#    linkstatic = False,
)
