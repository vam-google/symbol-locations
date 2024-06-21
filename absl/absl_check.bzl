def cc_header_only_library(
        name,
        deps = [],
        includes = [],
        extra_deps = [],
        compatible_with = None,
        **kwargs):
    _transitive_hdrs(
        name = name + "_gather",
        deps = deps,
        compatible_with = compatible_with,
    )
    _transitive_parameters_library(
        name = name + "_gathered_parameters",
        original_deps = deps,
        compatible_with = compatible_with,
    )
    native.cc_library(
        name = name,
        hdrs = [":" + name + "_gather"],
        includes = includes,
        compatible_with = compatible_with,
        deps = [":" + name + "_gathered_parameters"] + extra_deps,
        **kwargs
    )

def _transitive_hdrs_impl(ctx):
    outputs = depset(
        [],
        transitive = [dep[CcInfo].compilation_context.headers for dep in ctx.attr.deps],
    )
    return DefaultInfo(files = outputs)

_transitive_hdrs = rule(
    attrs = {
        "deps": attr.label_list(
            allow_files = True,
            providers = [CcInfo],
        ),
    },
    implementation = _transitive_hdrs_impl,
)

#def transitive_hdrs(name, deps = [], **kwargs):
#    _transitive_hdrs(name = name + "_gather", deps = deps)
#    native.filegroup(name = name, srcs = [":" + name + "_gather"])

def _get_transitive_headers(hdrs, deps):
    return depset(
        hdrs,
        transitive = [dep[CcInfo].compilation_context.headers for dep in deps],
    )

# Bazel rule for collecting the transitive parameters from a set of dependencies into a library.
# Propagates defines and includes.
def _transitive_parameters_library_impl(ctx):
    defines = depset(
        transitive = [dep[CcInfo].compilation_context.defines for dep in ctx.attr.original_deps],
    )
    system_includes = depset(
        transitive = [dep[CcInfo].compilation_context.system_includes for dep in ctx.attr.original_deps],
    )
    includes = depset(
        transitive = [dep[CcInfo].compilation_context.includes for dep in ctx.attr.original_deps],
    )
    quote_includes = depset(
        transitive = [dep[CcInfo].compilation_context.quote_includes for dep in ctx.attr.original_deps],
    )
    framework_includes = depset(
        transitive = [dep[CcInfo].compilation_context.framework_includes for dep in ctx.attr.original_deps],
    )
    return CcInfo(
        compilation_context = cc_common.create_compilation_context(
            defines = depset(direct = defines.to_list()),
            system_includes = depset(direct = system_includes.to_list()),
            includes = depset(direct = includes.to_list()),
            quote_includes = depset(direct = quote_includes.to_list()),
            framework_includes = depset(direct = framework_includes.to_list()),
        ),
    )

_transitive_parameters_library = rule(
    attrs = {
        "original_deps": attr.label_list(
            allow_empty = True,
            allow_files = True,
            providers = [CcInfo],
        ),
    },
    implementation = _transitive_parameters_library_impl,
)