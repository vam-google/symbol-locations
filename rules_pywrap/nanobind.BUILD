licenses(["notice"])

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "nanobind",
    srcs = glob(
        [
            "src/*.cpp",
        ],
        exclude = ["src/nb_combined.cpp"],
    ),
    copts = ["-fexceptions"],
    defines = select({
        "//conditions:default": [
            "NB_BUILD=1",
            "NB_SHARED=1",
        ],
    }),
    includes = ["include"],
    textual_hdrs = glob(
        [
            "include/**/*.h",
            "src/*.h",
        ],
    ),
    deps = [
        "@robin_map//:robin_map",
        "@local_config_python//:python_headers",
    ],
)
