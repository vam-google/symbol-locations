package(
    features = [
        "windows_export_all_symbols",
    ],
)

cc_binary(
    name = "main_dynamic",
    srcs = ["main.cc"],
    linkstatic = False,
    deps = ["one"],
)

cc_binary(
    name = "main_static",
    srcs = ["main.cc"],
    linkstatic = True,
    deps = ["one"],
)

cc_test(
    name = "main_test_dynamic",
    srcs = ["main_test.cc"],
    linkstatic = False,
    deps = [
        "//:one",
        "@gtest//:gtest_main",
    ],
)

cc_test(
    name = "main_test_static",
    srcs = ["main_test.cc"],
    linkstatic = True,
    deps = [
        "//:one",
        "@gtest//:gtest_main",
    ],
)

cc_library(
    name = "one",
    srcs = ["one.cc"],
    hdrs = ["one.h"],
    linkstatic = False,
    deps = [
        "four",
        "three",
        "two",
    ],
)

cc_library(
    name = "two",
    srcs = ["two.cc"],
    hdrs = ["two.h"],
    linkstatic = False,
    deps = [],
)

cc_library(
    name = "three",
    srcs = ["three.cc"],
    hdrs = ["three.h"],
    linkstatic = False,
    deps = [],
)

cc_library(
    name = "four",
    srcs = ["four.cc"],
    hdrs = ["four.h"],
    linkstatic = True,
    deps = [],
)

#
# Toolchains
# call build with --compiler=clang-cl on windows to use this toolchain
#
platform(
    name = "x64_windows-clang-cl",
    constraint_values = [
        "@platforms//cpu:x86_64",
        "@platforms//os:windows",
        "@bazel_tools//tools/cpp:clang-cl",
    ],
)
