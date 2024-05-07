load("//rules_pywrap:pywrap.bzl", "stripped_cc_info")
load(":proto.bzl", "proto_srcs")

proto_library(
    name = "my_proto_proto",
    srcs = ["my_proto.proto"],
)

cc_proto_library(
    name = "my_proto_library",
    deps = [":my_proto_proto"],
)

cc_library(
    name = "my_proto_cc_library",
    srcs = [
        "my_proto_symbols.cc"
    ],
    deps = [
        ":my_proto_library",
    ],
    alwayslink = True,
    visibility = ["//visibility:public"],
)

cc_library(
    name = "my_proto_cc_library_headers",
    hdrs = [":my_proto_library"],
    deps = [
        "@com_google_protobuf//:protobuf_headers",
    ],
    visibility = ["//visibility:public"],
)

cc_binary(
    name = "my_proto_cc_binary",
    deps = [
        ":my_proto_cc_library",
        "@com_google_protobuf//:protobuf",
    ],
    linkshared = True,
    linkstatic = True,
    win_def_file = "my_proto.def",
)

filegroup(
    name = "my_proto_if_lib",
    srcs = ["my_proto_cc_binary"],
    output_group = "interface_library",
)

cc_import(
    name = "my_proto_cc_import",
    shared_library = "my_proto_cc_binary",
    interface_library = "my_proto_if_lib",
)

cc_test(
    name = "proto_test",
    srcs = ["proto_test.cc"],
    deps = [
        "@gtest//:gtest_main",
        ":my_proto_cc_import",
        "@com_google_protobuf//:protobuf_headers",
        ":my_proto_cc_library_headers",
    ],
    local_defines = ["PROTOBUF_USE_DLLS"],
    linkstatic = False,
)
