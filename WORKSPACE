load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#register_toolchains(
#    "@local_config_cc//:cc-toolchain-x64_windows-clang-cl",
#)
#
#register_execution_platforms(
#    "//:x64_windows-clang-cl"
#)

http_archive(
    name = "gtest",
    sha256 = "ffa17fbc5953900994e2deec164bb8949879ea09b411e07f215bfbb1f87f4632",
    strip_prefix = "googletest-1.13.0",
    url = "https://github.com/google/googletest/archive/refs/tags/v1.13.0.zip",
)

http_archive(
    name = "pybind11_bazel",
    strip_prefix = "pybind11_bazel-faf56fb3df11287f26dbc66fdedf60a2fc2c6631",
    urls = ["https://github.com/pybind/pybind11_bazel/archive/faf56fb3df11287f26dbc66fdedf60a2fc2c6631.zip"],
)

http_archive(
    name = "pybind11",
    build_file = "@pybind11_bazel//:pybind11.BUILD",
    strip_prefix = "pybind11-2.11.1",
    urls = ["https://github.com/pybind/pybind11/archive/v2.11.1.tar.gz"],
)

http_archive(
    name = "rules_python",
    strip_prefix = "rules_python-0.25.0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.25.0/rules_python-0.25.0.tar.gz",
)

http_archive(
    name = "bazel_skylib",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
    ],
    sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()

load("@rules_python//python:repositories.bzl", "python_register_toolchains")
python_register_toolchains(
    name = "python3_11",
    python_version = "3.11",
)

load("@python3_11//:defs.bzl", "interpreter")
load("@pybind11_bazel//:python_configure.bzl", "python_configure")
python_configure(
    name = "local_config_python",
    python_interpreter_target = interpreter,
)