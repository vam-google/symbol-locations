load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain", "use_cpp_toolchain")

# TODO: we need to generate win_def_file, but it should be simple
def pywrap_library(
        name,
        deps,
        win_def_file,
        # For demonstration purposes only.
        # For real work we always want:
        #   generate_common_lib = True
        # as it is the whole point of pywrap_extension
        generate_common_lib = True):
    # 1) Create common pywrap library. The common library should link in
    # everything except the object file with Python Extension's init function
    # PyInit_<extension_name>.
    #
    pywrap_common_name = "_%s_pywrap_common" % (name)
    pywrap_split_library(
        name = pywrap_common_name,
        deps = deps,
        keep_deps = True,
    )

    pywrap_common_cc_binary_name = "%s_pywrap_common" % (name)
    native.cc_binary(
        name = pywrap_common_cc_binary_name,
        deps = [":%s" % pywrap_common_name],
        linkstatic = True,
        linkshared = True,
        win_def_file = win_def_file,
    )

    # The following filegroup/cc_import shenanigans to extract .if.lib from
    # cc_binary should not be needed, but otherwise bazel can't consume
    # cc_binary properly as a dep in downstream cc_binary/cc_test targets.
    # I.e. cc_binary does not work as a dependency downstream, but if wrapped
    # into a cc_import it all of a sudden starts working. I wish bazel team
    # fixed it...
    pywrap_common_if_lib_name = "%s_if_lib" % (pywrap_common_name)
    native.filegroup(
        name = pywrap_common_if_lib_name,
        srcs = [":%s" % pywrap_common_cc_binary_name],
        output_group = "interface_library",
    )

    pywrap_common_import_name = "%s_import" % pywrap_common_name
    native.cc_import(
        name = pywrap_common_import_name,
        interface_library = ":%s" % pywrap_common_if_lib_name,
        shared_library = ":%s" % pywrap_common_cc_binary_name,
    )

    # 2) Create individual super-thin pywrap libraries, which depend on the
    # common one. The individual libraries must link in statically only the
    # object file with Python Extension's init function PyInit_<extension_name>
    #
    if generate_common_lib:
        outs_win = [":%s" % pywrap_common_cc_binary_name]
        outs = [":%s" % pywrap_common_cc_binary_name]
    else:
        outs_win = []
        outs = []
    outs_data = []

    for dep in deps:
        dep_name = Label(dep).name
        pybind_lib_name = "_%s_shared_object" % dep_name
        pybind_lib_win_def_file = "_%s_win_def" % dep_name

        common_deps = ["@pybind11//:pybind11"]  # why do we need it?
        if generate_common_lib:
            pywrap_lib_name = "_%s_pywrap" % pybind_lib_name
            pywrap_split_library(
                name = pywrap_lib_name,
                deps = [dep],
                keep_deps = False,
            )
            common_deps.append(":%s" % pywrap_common_import_name)
        else:
            pywrap_lib_name = dep_name
        outs_data.append(":%s" % pybind_lib_name)

        native.cc_binary(
            name = pybind_lib_name,
            srcs = [],
            deps = [":%s" % pywrap_lib_name] + common_deps,
            linkstatic = generate_common_lib,
            linkshared = True,
            win_def_file = pybind_lib_win_def_file,
        )

        # The following two genrules are mutually exclusive
        # only one will be performed on each platform
        pybind_dyn_lib_file_name_win = "%s.pyd" % dep_name
        native.genrule(
            name = "_%s_dyn_lib_win" % pybind_lib_name,
            srcs = ["%s" % pybind_lib_name],
            outs = [pybind_dyn_lib_file_name_win],
            cmd = "cp $< $@;",
        )
        pybind_dyn_lib_file_name = "%s.so" % dep_name
        native.genrule(
            name = "_%s_dyn_lib" % pybind_lib_name,
            srcs = ["%s" % pybind_lib_name],
            outs = [pybind_dyn_lib_file_name],
            cmd = "cp $< $@;",
        )
        outs_win.append(":%s" % pybind_dyn_lib_file_name_win)
        outs.append(":%s" % pybind_dyn_lib_file_name)

    # 3) The output of this macro is a single filegroup, which has the single
    # common library and all thin individual wrappers (with proper
    # platform-specific file extensions) together. Ready to be added as a simple
    # "data" entry in any py_test or py_binary target down the stream.
    #
    # The filegroup is for debugging purposes (never used for anything real)
    native.filegroup(
        name = "_%s_filegroup" % name,
        srcs = select({
            "@bazel_tools//src/conditions:windows": outs_win + outs_data,
            "//conditions:default": outs + outs_data,
        }),
        data = outs_data,
    )

    native.py_library(
        name = name,
        srcs = [],
        data = select({
            "@bazel_tools//src/conditions:windows": outs_win + outs_data,
            "//conditions:default": outs + outs_data,
        }),
    )

def pybind_extension(
        name,
        srcs,
        deps,
        win_def_file = None,
        **kwargs):
    win_def_file_name = "_%s_win_def" % name
    native.cc_library(
        name = name,
        deps = deps + ["@pybind11//:pybind11"],
        srcs = srcs,
        linkstatic = True,
        alwayslink = True,
        **kwargs
    )

    if not win_def_file:
        native.genrule(
            name = win_def_file_name,
            srcs = [],
            outs = ["%s.def" % win_def_file_name],
            cmd = "echo \"EXPORTS\r\n  PyInit_%s\">> $@" % name,
        )
    else:
        native.alias(
            name = win_def_file_name,
            actual = ":%s" % win_def_file,
        )

def _pywrap_split_library_impl(ctx):
    deps = ctx.attr.deps
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    keep_deps = ctx.attr.keep_deps
    dependency_libraries = []

    for dep in ctx.attr.deps:
        # TODO: we should not rely on order of object files in CcInfo
        no_of_deps_extracted = 0
        for d in dep[CcInfo].linking_context.linker_inputs.to_list():
            if keep_deps and not no_of_deps_extracted:
                no_of_deps_extracted += 1
                continue
            for lib in d.libraries:
                lib_copy = cc_common.create_library_to_link(
                    actions = ctx.actions,
                    cc_toolchain = cc_toolchain,
                    feature_configuration = feature_configuration,
                    static_library = lib.static_library,
                    pic_static_library = lib.pic_static_library,
                    # dynamic_library = lib.dynamic_library,
                    # dynamic_library_symlink_path = "",
                    # interface_library_symlink_path = "",
                    interface_library = lib.interface_library,
                    alwayslink = True,
                )
            no_of_deps_extracted += 1
            dependency_libraries.append(lib_copy)
            if not keep_deps:
                break

    linker_input = cc_common.create_linker_input(
        owner = ctx.label,
        libraries = depset(direct = dependency_libraries),
    )

    linking_context = cc_common.create_linking_context(
        linker_inputs = depset(direct = [linker_input]),
    )

    return [CcInfo(linking_context = linking_context)]

pywrap_split_library = rule(
    attrs = {
        "deps": attr.label_list(
            allow_files = True,
            providers = [CcInfo],
        ),
        "_cc_toolchain": attr.label(
            default = "@bazel_tools//tools/cpp:current_cc_toolchain",
        ),
        "keep_deps": attr.bool(),
    },
    fragments = ["cpp"],
    toolchains = use_cpp_toolchain(),
    implementation = _pywrap_split_library_impl,
)
