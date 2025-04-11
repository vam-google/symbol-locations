load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def pywrap_repositories():
    http_archive(
        name = "gtest",
        sha256 = "ffa17fbc5953900994e2deec164bb8949879ea09b411e07f215bfbb1f87f4632",
        strip_prefix = "googletest-1.13.0",
        url = "https://github.com/google/googletest/archive/refs/tags/v1.13.0.zip",
    )

    http_archive(
        name = "robin_map",
        strip_prefix = "robin-map-1.3.0",
        sha256 = "a8424ad3b0affd4c57ed26f0f3d8a29604f0e1f2ef2089f497f614b1c94c7236",
        urls = ["https://github.com/Tessil/robin-map/archive/refs/tags/v1.3.0.tar.gz"],
        build_file = Label("//rules_pywrap:robin_map.BUILD"),
    )

    http_archive(
        name = "nanobind",
        strip_prefix = "nanobind-b4b933111fa61815f3f5b509fde80c24f029ac26",
        sha256 = "d1d8575f2bf76cc2ca357ac5521daa2f1bcf5397231d856f4ce66ba0670ac928",
        urls = ["https://github.com/wjakob/nanobind/archive/b4b933111fa61815f3f5b509fde80c24f029ac26.tar.gz"],
        build_file = Label("//rules_pywrap:nanobind.BUILD"),
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
        strip_prefix = "rules_python-0.39.0",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.39.0/rules_python-0.39.0.tar.gz",
    )

    # We do not need these and do not use them, but without them bazel query fails
    # because some of bazel_skylib rules depend on them on analysis phase
    http_archive(
        name = "com_google_absl",
        sha256 = "0320586856674d16b0b7a4d4afb22151bdc798490bb7f295eddd8f6a62b46fea",
        patch_args = ["-p1"],
        patches = [Label("//rules_pywrap:absl.patch")],
        strip_prefix = "abseil-cpp-fb3621f4f897824c0dbe0615fa94543df6192f30",
        urls = ["https://github.com/abseil/abseil-cpp/archive/fb3621f4f897824c0dbe0615fa94543df6192f30.tar.gz"],
    )

    http_archive(
        name = "com_googlesource_code_re2",
        sha256 = "ef516fb84824a597c4d5d0d6d330daedb18363b5a99eda87d027e6bdd9cba299",
        strip_prefix = "re2-03da4fc0857c285e3a26782f6bc8931c4c950df4",
        urls = ["https://github.com/google/re2/archive/03da4fc0857c285e3a26782f6bc8931c4c950df4.tar.gz"],
    )

    http_archive(
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
        ],
        sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    )

    http_archive(
        name = "com_google_protobuf",
        patch_args = ["-p1"],
        patches = [Label("//rules_pywrap:protobuf.patch")],
        sha256 = "f66073dee0bc159157b0bd7f502d7d1ee0bc76b3c1eac9836927511bdc4b3fc1",
        strip_prefix = "protobuf-3.21.9",
        urls = ["https://github.com/protocolbuffers/protobuf/archive/v3.21.9.zip"],
    )

    http_archive(
        name = "rules_pkg",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.7.1/rules_pkg-0.7.1.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/0.7.1/rules_pkg-0.7.1.tar.gz",
        ],
        sha256 = "451e08a4d78988c06fa3f9306ec813b836b1d076d0f055595444ba4ff22b867f",
    )