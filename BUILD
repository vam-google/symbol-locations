LINKABLE_MORE_THAN_ONCE = "LINKABLE_MORE_THAN_ONCE"

cc_binary(
    name = "main",
    srcs = ["main.cc"],
    linkstatic = False,
    deps = ["one"],
)

cc_library(
    name = "one",
    srcs = [
        "one.cc",
    ],
    hdrs = [
        "one.h",
    ],
    deps = [
        "three",
        "two",
    ],
)

cc_library(
    name = "two",
    srcs = [
        "two.cc",
    ],
    hdrs = [
        "two.h",
    ],
    deps = [
    ],
)

cc_library(
    name = "three",
    srcs = [
        "three.cc",
    ],
    hdrs = [
        "three.h",
    ],
    deps = [
    ],
)
