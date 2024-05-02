workspace(name = "symbol_locations")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//rules_pywrap:pywrap_repositories.bzl", "pywrap_repositories")

pywrap_repositories()

load("@rules_python//python:repositories.bzl", "py_repositories")

py_repositories()

load("@rules_python//python:repositories.bzl", "python_register_toolchains")
python_register_toolchains(
    name = "python3_11",
    python_version = "3.11",
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()

load("@python3_11//:defs.bzl", "interpreter")
load("@pybind11_bazel//:python_configure.bzl", "python_configure")
python_configure(
    name = "local_config_python",
    python_interpreter_target = interpreter,
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
protobuf_deps()
