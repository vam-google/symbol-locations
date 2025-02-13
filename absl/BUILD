load("//absl:absl_check.bzl", "cc_header_only_library")

cc_library(
    name = "absl_check_cc_library",
    srcs = [
        "absl_check.cc",
    ],
    hdrs = [
        "absl_check.h",
    ],
    local_defines = ["ABSL_BUILD_DLL"],
    visibility = ["//visibility:public"],
    deps = [
        "@com_google_absl//absl/container:flat_hash_map",
    ],
    alwayslink = True,
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
    linkshared = True,
    linkstatic = True,
    win_def_file = "absl_check.def",
    deps = [
        ":absl_check_cc_library",
    ],
)

filegroup(
    name = "absl_check_if_lib",
    srcs = ["absl_check_cc_binary"],
    output_group = "interface_library",
)

cc_import(
    name = "absl_check_cc_import",
    interface_library = "absl_check_if_lib",
    shared_library = "absl_check_cc_binary",
)

cc_test(
    name = "absl_test",
    srcs = ["absl_test.cc"],
    local_defines = ["ABSL_CONSUME_DLL"],
    visibility = ["//:__pkg__"],
    deps = [
        "@gtest//:gtest_main",
        ":absl_check_cc_library_headers",
        ":absl_check_cc_import",
        #        "@com_google_absl//absl/container:flat_hash_map",
    ],
    #    linkstatic = False,
)
