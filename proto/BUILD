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

proto_srcs(
    name = "my_proto_srcs",
    deps = [":my_proto_library"],
    extension = "cc",
)

proto_srcs(
    name = "my_proto_hdrs",
    deps = [":my_proto_library"],
    extension = "h",
)

cc_library(
    name = "my_proto_cc_library",
    hdrs = [":my_proto_hdrs"],
    srcs = [":my_proto_srcs"],
    deps = [
        "@com_google_protobuf//:protobuf",
    ],
    alwayslink = True,
    local_defines = ["PROTOBUF_USE_DLLS", "LIBPROTOBUF_EXPORTS"]
)

cc_library(
    name = "my_proto_cc_library_headers",
    hdrs = [":my_proto_hdrs"],
    deps = [
        "@com_google_protobuf//:protobuf_headers",
    ],
    local_defines = ["PROTOBUF_USE_DLLS", "LIBPROTOBUF_EXPORTS"]
)

cc_binary(
    name = "my_proto_cc_binary",
    deps = [
        "my_proto_cc_library",
    ],
    linkshared = True,
    linkstatic = True,
#    win_def_file = "my_proto.def",
    local_defines = ["PROTOBUF_USE_DLLS", "LIBPROTOBUF_EXPORTS"]
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
