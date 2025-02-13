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
        "my_proto_symbols.cc",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":my_proto_library",
    ],
    alwayslink = True,
)

cc_library(
    name = "my_proto_cc_library_headers",
    hdrs = [":my_proto_library"],
    visibility = ["//visibility:public"],
    deps = [
        "@com_google_protobuf//:protobuf_headers",
    ],
)

cc_binary(
    name = "my_proto_cc_binary",
    linkshared = True,
    linkstatic = True,
    win_def_file = "my_proto.def",
    deps = [
        ":my_proto_cc_library",
        "@com_google_protobuf//:protobuf",
    ],
)

filegroup(
    name = "my_proto_if_lib",
    srcs = ["my_proto_cc_binary"],
    output_group = "interface_library",
)

cc_import(
    name = "my_proto_cc_import",
    interface_library = "my_proto_if_lib",
    shared_library = "my_proto_cc_binary",
)

cc_test(
    name = "proto_test",
    srcs = ["proto_test.cc"],
    linkstatic = False,
    local_defines = ["PROTOBUF_USE_DLLS"],
    visibility = ["//:__pkg__"],
    deps = [
        ":my_proto_cc_import",
        ":my_proto_cc_library_headers",
        "@com_google_protobuf//:protobuf_headers",
        "@gtest//:gtest_main",
    ],
)
