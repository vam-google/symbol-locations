package(
    features = [
        "windows_export_all_symbols",
    ],
)


#
# second cc_library linking variants
#
cc_library(
    name = "second_00",
    srcs = ["second.cc"],
    hdrs = [":second.h"],
    deps = [],
    linkstatic = False,
    alwayslink = True,
)

cc_library(
    name = "second_01",
    srcs = ["second.cc"],
    hdrs = [":second.h"],
    deps = [],
    linkstatic = False,
    alwayslink = True,
    linkopts = ["-lpthread", "-lpthread"],
)

cc_library(
    name = "second_10",
    srcs = ["second.cc"],
    hdrs = [":second.h"],
    deps = [],
    linkstatic = True,
    alwayslink = False
)

cc_library(
    name = "second_11",
    srcs = ["second.cc"],
    hdrs = [":second.h"],
    deps = [],
    linkstatic = True,
    alwayslink = True,
)

cc_binary(
    name = "binary_01__second_00",
#    srcs = ["links_shared_second.cc"],
    deps = [":second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__second_01",
#    srcs = ["links_shared_second.cc"],
    deps = [":second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__second_10",
#    srcs = ["links_shared_second.cc"],
    deps = [":second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__second_11",
#    srcs = ["links_shared_second.cc"],
    deps = [":second_11"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_11__second_01",
#    srcs = ["links_shared_second.cc"],
    deps = [":second_01"],
    linkstatic = False,
    linkshared = True
)


cc_binary(
    name = "direct_binary_01__first_00__second_00",
    srcs = [":binary_01__second_00", "first.cc", "first.h"],
    deps = [":binary_01__second_00"],
    linkstatic = False,
    linkshared = True,
)

cc_binary(
    name = "direct_binary_01__first_00__second_11",
    srcs = [":binary_01__second_11", "first.cc", "first.h"],
    deps = [":binary_01__second_11"],
    linkstatic = False,
    linkshared = True,
)

cc_test(
    name = "test_0_direct_binary_01__first_00__second_00",
    srcs = [":binary_01__second_00", ":direct_binary_01__first_00__second_00", ":links_test.cc", ],
    deps = [
        ":binary_01__second_00",
        ":direct_binary_01__first_00__second_00",
        ":second_00",
        "@gtest//:gtest_main"
    ],
    linkstatic = False,
)


cc_test(
    name = "test_0_direct_binary_01__first_00__second_11",
    srcs = [":binary_01__second_11", ":direct_binary_01__first_00__second_11", ":links_test.cc", ],
    deps = [
        ":binary_01__second_11",
        ":direct_binary_01__first_00__second_11",
        "@gtest//:gtest_main"
    ],
    linkstatic = False,
)

#cc_test(
#    name = "test_0_direct_binary_01__first_00__second_11",
#    srcs = [":binary_01__second_11", ":direct_binary_01__first_00__second_11", ":links_test.cc", ],
#    deps = [
#        ":binary_01__second_11",
#        ":direct_binary_01__first_00__second_11",
#        "@gtest//:gtest_main"
#    ],
#    linkstatic = False,
#)



#
# first cc_library linking combinations: 4 * 4 = 16
#
# first_00 * (second_01, second_01, second_10, second_11)
#
cc_library(
    name = "first_00__second_00",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_00"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "first_00__second_01",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_01"],
    linkstatic = False,
    alwayslink = False,
    linkopts = ["-lrt", "-lrt"],
)

cc_library(
    name = "first_00__second_10",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_10"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "first_00__second_11",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_11"],
    linkstatic = False,
    alwayslink = False,
)

#
# first_01 * (second_01, second_01, second_10, second_11)
#
cc_library(
    name = "first_01__second_00",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_00"],
    linkstatic = False,
    alwayslink = True,
)

cc_library(
    name = "first_01__second_01",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_01"],
    linkstatic = False,
    alwayslink = True,
)

cc_library(
    name = "first_01__second_10",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_10"],
    linkstatic = False,
    alwayslink = True,
)

cc_library(
    name = "first_01__second_11",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_11"],
    linkstatic = False,
    alwayslink = True,
)

#
# first_10 * (second_01, second_01, second_10, second_11)
cc_library(
    name = "first_10__second_00",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_00"],
    linkstatic = True,
    alwayslink = False,
)

cc_library(
    name = "first_10__second_01",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_01"],
    linkstatic = True,
    alwayslink = False,
)

cc_library(
    name = "first_10__second_10",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_10"],
    linkstatic = True,
    alwayslink = False,
)

cc_library(
    name = "first_10__second_11",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_11"],
    linkstatic = True,
    alwayslink = False,
)

#
# first_11 * (second_01, second_01, second_10, second_11)
#
cc_library(
    name = "first_11__second_00",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_00"],
    linkstatic = True,
    alwayslink = True,
)

cc_library(
    name = "first_11__second_01",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_01"],
    linkstatic = True,
    alwayslink = True,
)

cc_library(
    name = "first_11__second_10",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_10"],
    linkstatic = True,
    alwayslink = True,
)

cc_library(
    name = "first_11__second_11",
    srcs = ["first.cc"],
    hdrs = ["first.h"],
    deps = [":second_11"],
    linkstatic = True,
    alwayslink = True,
)

#
# srcs deps
#
cc_library(
    name = "srcs_first_00__second_00",
    srcs = [":second_00", "first.cc"],
    hdrs = ["first.h"],
    linkstatic = False,
    alwayslink = False,
)

cc_library(
    name = "srcs_first_11__second_11",
    srcs = [":second_11", "first.cc"],
    hdrs = ["first.h"],
    linkstatic = True,
    alwayslink = True,
)

cc_library(
    name = "srcs_first_01__second_10",
    srcs = [":second_10", "first.cc"],
    hdrs = ["first.h"],
    linkstatic = False,
    alwayslink = True,
)

#
# Raw tests
#
cc_test(
    name = "raw_test_0__first_00__second_00",
    srcs = [":links_test.cc", ],
    deps = [
        ":first_00__second_00",
        "@gtest//:gtest_main"
    ],
    linkstatic = False,
)

cc_test(
    name = "raw_test_0__first_00__second_10",
    srcs = [":links_test.cc", ],
    deps = [
        ":first_00__second_10",
        "@gtest//:gtest_main"
    ],
    linkstatic = False,
)

cc_test(
    name = "raw_test_0__first_11__second_11",
    srcs = [":links_test.cc", ],
    deps = [
        ":first_11__second_11",
        "@gtest//:gtest_main"
    ],
    linkstatic = False,
)


#
# binary linking variants (links first library)
#
cc_binary(
    name = "binary_01__first_00__second_00",
    srcs = [],
    deps = [":first_00__second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_00__second_01",
    srcs = [],
    deps = [":first_00__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_00__second_10",
    srcs = [],
    deps = [":first_00__second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_00__second_11",
    srcs = [],
    deps = [":first_00__second_11"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_01__second_00",
    srcs = [],
    deps = [":first_01__second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_01__second_01",
    srcs = [],
    deps = [":first_01__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_01__second_10",
    srcs = [],
    deps = [":first_01__second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_01__second_11",
    srcs = [],
    deps = [":first_01__second_11"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_10__second_00",
    srcs = [],
    deps = [":first_10__second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_10__second_01",
    srcs = [],
    deps = [":first_10__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_10__second_10",
    srcs = [],
    deps = [":first_10__second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_10__second_11",
    srcs = [],
    deps = [":first_10__second_11"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_11__second_00",
    srcs = [],
    deps = [":first_11__second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_11__second_01",
    srcs = [],
    deps = [":first_11__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_11__second_10",
    srcs = [],
    deps = [":first_11__second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "binary_01__first_11__second_11",
    srcs = [],
    deps = [":first_11__second_11"],
    linkstatic = False,
    linkshared = True
)


cc_binary(
    name = "binary_11__first_00__second_00",
    srcs = [],
    deps = [":first_00__second_00"],
    linkstatic = True,
    linkshared = True
)

cc_binary(
    name = "binary_11__first_00__second_01",
    srcs = [],
    deps = [":first_00__second_01"],
    linkstatic = True,
    linkshared = True
)

cc_binary(
    name = "binary_11__first_01__second_00",
    srcs = [],
    deps = [":first_01__second_00"],
    linkstatic = True,
    linkshared = True
)


#
# used binary
#
cc_binary(
    name = "used_binary_01__first_00__second_00",
    srcs = ["links_shared.cc"],
    deps = [":first_00__second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_00__second_01",
    srcs = ["links_shared.cc"],
    deps = [":first_00__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_00__second_10",
    srcs = ["links_shared.cc"],
    deps = [":first_00__second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_00__second_11",
    srcs = ["links_shared.cc"],
    deps = [":first_00__second_11"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_01__second_00",
    srcs = ["links_shared.cc"],
    deps = [":first_01__second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_01__second_01",
    srcs = ["links_shared.cc"],
    deps = [":first_01__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_01__second_10",
    srcs = ["links_shared.cc"],
    deps = [":first_01__second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_01__second_11",
    srcs = ["links_shared.cc"],
    deps = [":first_01__second_11"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_10__second_00",
    srcs = ["links_shared.cc"],
    deps = [":first_10__second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_10__second_01",
    srcs = ["links_shared.cc"],
    deps = [":first_10__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_10__second_10",
    srcs = ["links_shared.cc"],
    deps = [":first_10__second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_10__second_11",
    srcs = ["links_shared.cc"],
    deps = [":first_10__second_11"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_11__second_00",
    srcs = ["links_shared.cc"],
    deps = [":first_11__second_00"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_11__second_01",
    srcs = ["links_shared.cc"],
    deps = [":first_11__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_11__second_10",
    srcs = ["links_shared.cc"],
    deps = [":first_11__second_10"],
    linkstatic = False,
    linkshared = True
)

cc_binary(
    name = "used_binary_01__first_11__second_11",
    srcs = ["links_shared.cc"],
    deps = [":first_11__second_11"],
    linkstatic = False,
    linkshared = True,
    features = [
        "windows_export_all_symbols",
    ],
)

cc_binary(
    name = "used_binary_11__first_00__second_00",
    srcs = ["links_shared.cc"],
    deps = [":first_00__second_00"],
    linkstatic = True,
    linkshared = True
)


#
# both first binary and second binary as cc_binary
#

cc_import(
    name = "import_binary_01__second_01",
    shared_library = ":binary_01__second_01"
)

cc_import(
    name = "import_binary_01__first_01__second_01",
    shared_library = ":binary_01__first_01__second_01"
)


cc_binary(
    name = "double_binary_01__first_01__second_01",
    srcs = [],
    deps = [":import_binary_01__second_01",
            ":import_binary_01__first_01__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_test(
    name = "test_0_double_binary_01__first_01_second_10",
    srcs = [":links_test.cc"],
    deps = [
        ":double_binary_01__first_01__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)



cc_import(
    name = "import_binary_01__second_11",
    shared_library = ":binary_01__second_11"
)

cc_import(
    name = "import_binary_01__first_11__second_01",
    shared_library = ":binary_01__first_11__second_01"
)

cc_import(
    name = "import_binary_01__first_11__second_11",
    shared_library = ":binary_01__first_11__second_11"
)


cc_binary(
    name = "double_binary_01__first_11__second_01",
    srcs = [],
    deps = [":import_binary_01__second_11",
            ":import_binary_01__first_11__second_01"],
    linkstatic = False,
    linkshared = True
)

cc_test(
    name = "test_0_double_binary_01__first_11_second_01",
    srcs = ["first.h", "second.h", ":links_test.cc"],
    deps = [
        "import_binary_01__first_11__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)


#
# Tests
#

cc_test(
    name = "test_0_binary_01__first_00__second_00",
    srcs = [":binary_01__first_00__second_00", ":links_test.cc", ],
    deps = [
        ":binary_01__first_00__second_00",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_00__second_01",
    srcs = [":binary_01__first_00__second_01", ":links_test.cc", ],
    deps = [
        ":binary_01__first_00__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_00__second_10",
    srcs = [":binary_01__first_00__second_10", ":links_test.cc", ],
    deps = [
        ":binary_01__first_00__second_10",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_00__second_11",
    srcs = [":binary_01__first_00__second_11", ":links_test.cc", ],
    deps = [
        ":binary_01__first_00__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_01__second_00",
    srcs = [":binary_01__first_01__second_00", ":links_test.cc", ],
    deps = [
        ":binary_01__first_01__second_00",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_01__second_01",
    srcs = [":binary_01__first_01__second_01", ":links_test.cc", ],
    deps = [
        ":binary_01__first_01__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_01__second_10",
    srcs = [":binary_01__first_01__second_10", ":links_test.cc", ],
    deps = [
        ":binary_01__first_01__second_10",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_01__second_11",
    srcs = [":binary_01__first_01__second_11", ":links_test.cc", ],
    deps = [
        ":binary_01__first_01__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_10__second_00",
    srcs = [":binary_01__first_10__second_00", ":links_test.cc", ],
    deps = [
        ":binary_01__first_10__second_00",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_10__second_01",
    srcs = [":binary_01__first_10__second_01", ":links_test.cc", ],
    deps = [
        ":binary_01__first_10__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_10__second_10",
    srcs = [":binary_01__first_10__second_10", ":links_test.cc", ],
    deps = [
        ":binary_01__first_10__second_10",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_10__second_11",
    srcs = [":binary_01__first_10__second_11", ":links_test.cc", ],
    deps = [
        ":binary_01__first_10__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_11__second_00",
    srcs = [":binary_01__first_11__second_00", ":links_test.cc", ],
    deps = [
        ":binary_01__first_11__second_00",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_11__second_01",
    srcs = [":binary_01__first_11__second_01", ":links_test.cc", ],
    deps = [
        ":binary_01__first_11__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_11__second_10",
    srcs = [":binary_01__first_11__second_10", ":links_test.cc", ],
    deps = [
        ":binary_01__first_11__second_10",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_0_binary_01__first_11__second_11",
    srcs = [":binary_01__first_11__second_11", ":links_test.cc", ],
    deps = [
        ":binary_01__first_11__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)


cc_test(
    name = "used_test_0_binary_01__first_00__second_00",
    srcs = [":used_binary_01__first_00__second_00", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_00__second_00",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_00__second_01",
    srcs = [":used_binary_01__first_00__second_01", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_00__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_00__second_10",
    srcs = [":used_binary_01__first_00__second_10", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_00__second_10",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_00__second_11",
    srcs = [":used_binary_01__first_00__second_11", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_00__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_01__second_00",
    srcs = [":used_binary_01__first_01__second_00", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_01__second_00",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_01__second_01",
    srcs = [":used_binary_01__first_01__second_01", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_01__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_01__second_10",
    srcs = [":used_binary_01__first_01__second_10", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_01__second_10",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_01__second_11",
    srcs = [":used_binary_01__first_01__second_11", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_01__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_10__second_00",
    srcs = [":used_binary_01__first_10__second_00", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_10__second_00",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_10__second_01",
    srcs = [":used_binary_01__first_10__second_01", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_10__second_01",
#        ":second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0__first_10__second_01",
    srcs = [":links_test.cc", ],
    deps = [
        ":first_10__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_10__second_10",
    srcs = [":used_binary_01__first_10__second_10", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_10__second_10",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_10__second_11",
    srcs = [":used_binary_01__first_10__second_11", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_10__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_11__second_00",
    srcs = [":used_binary_01__first_11__second_00", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_11__second_00",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_11__second_01",
    srcs = [":used_binary_01__first_11__second_01", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_11__second_01",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_11__second_10",
    srcs = [":used_binary_01__first_11__second_10", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_11__second_10",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "used_test_0_binary_01__first_11__second_11",
    srcs = [":used_binary_01__first_11__second_11", ":links_test.cc", ],
    deps = [
        ":used_binary_01__first_11__second_11",
        "@gtest//:gtest_main"],
    linkstatic = False,
)

cc_test(
    name = "test_1_binary_01__first_00__second_00",
    srcs = [":binary_01__first_00__second_00", ":links_test.cc", ],
    deps = [
        ":binary_01__first_00__second_00",
        "@gtest//:gtest_main"],
    linkstatic = True,
)





test_suite(
    name = "suite_0",
    tests = [
        "test_0_binary_01__first_00__second_00",
        "test_0_binary_01__first_00__second_01",
        "test_0_binary_01__first_00__second_10",
        "test_0_binary_01__first_00__second_11",
        "test_0_binary_01__first_01__second_00",
        "test_0_binary_01__first_01__second_01",
        "test_0_binary_01__first_01__second_10",
        "test_0_binary_01__first_01__second_11",
        "test_0_binary_01__first_10__second_00",
        "test_0_binary_01__first_10__second_01",
        "test_0_binary_01__first_10__second_10",
        "test_0_binary_01__first_10__second_11",
        "test_0_binary_01__first_11__second_00",
        "test_0_binary_01__first_11__second_01",
        "test_0_binary_01__first_11__second_10",
        "test_0_binary_01__first_11__second_11",


        "used_test_0_binary_01__first_00__second_00",
        "used_test_0_binary_01__first_00__second_01",
        "used_test_0_binary_01__first_00__second_10",
        "used_test_0_binary_01__first_00__second_11",
        "used_test_0_binary_01__first_01__second_00",
        "used_test_0_binary_01__first_01__second_01",
        "used_test_0_binary_01__first_01__second_10",
        "used_test_0_binary_01__first_01__second_11",
        "used_test_0_binary_01__first_10__second_00",
        "used_test_0_binary_01__first_10__second_01",
        "used_test_0_binary_01__first_10__second_10",
        "used_test_0_binary_01__first_10__second_11",
        "used_test_0_binary_01__first_11__second_00",
        "used_test_0_binary_01__first_11__second_01",
        "used_test_0_binary_01__first_11__second_10",
        "used_test_0_binary_01__first_11__second_11",
    ]
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
