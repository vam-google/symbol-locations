load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain", "use_cpp_toolchain")

def _pywrap_library_impl(ctx):
    deps = ctx.attr.deps

    py_init_libraries = []
    for dep in ctx.attr.deps:
        d = dep[CcInfo].linking_context.linker_inputs.to_list()[0]
        py_init_libraries.extend(d.libraries)

    linker_input = cc_common.create_linker_input(
        owner = ctx.label,
        libraries = depset(direct = py_init_libraries),
    )

    linking_context = cc_common.create_linking_context(
        linker_inputs = depset(direct = [linker_input])
    )

    return [CcInfo(linking_context = linking_context)]

pywrap_library = rule(
    attrs = {
        "deps": attr.label_list(
            allow_files = True,
            providers = [CcInfo],
        ),
    },
    implementation = _pywrap_library_impl,
)


def _pywrap_common_library_impl(ctx):
    deps = ctx.attr.deps
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    dependency_libraries = []
    for dep in ctx.attr.deps:
        for d in dep[CcInfo].linking_context.linker_inputs.to_list()[1:]:
            for lib in d.libraries:
                lib_copy = cc_common.create_library_to_link(
                    actions = ctx.actions,
                    cc_toolchain = cc_toolchain,
                    feature_configuration = feature_configuration,
                    static_library = lib.static_library,
                    pic_static_library = lib.pic_static_library,
#                    dynamic_library = lib.dynamic_library,
#                    dynamic_library_symlink_path = "",
#                    interface_library_symlink_path = "",
                    interface_library = lib.interface_library,
                    alwayslink = True,
                )
            dependency_libraries.append(lib_copy)


    linker_input = cc_common.create_linker_input(
        owner = ctx.label,
        libraries = depset(direct = dependency_libraries),
    )

    linking_context = cc_common.create_linking_context(
        linker_inputs = depset(direct = [linker_input])
    )

    return [CcInfo(linking_context = linking_context)]

pywrap_common_library = rule(
    attrs = {
        "deps": attr.label_list(
            allow_files = True,
            providers = [CcInfo],
        ),
        "_cc_toolchain": attr.label(
            default = "@bazel_tools//tools/cpp:current_cc_toolchain"
        ),
    },
    fragments = ["cpp"],
    toolchains = use_cpp_toolchain(),
    implementation = _pywrap_common_library_impl,
)