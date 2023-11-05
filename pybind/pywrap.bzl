load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain", "use_cpp_toolchain")


# TODO: we need to generate win_def_file, but it should be simple
def pywrap_extension(
        name,
        deps,
        common_win_def_file):

    # 1) Create common pywrap library. The common library should link in
    # everything except the object file with Python Extension's init function
    # PyInit_<extension_name>.
    #
    normalized_deps = {}
    pywrap_common_deps = []
    for dep_label, dep_props in deps.items():
        normalized_dep_label = Label(dep_label)
        normalized_windef_label = Label(dep_props[1])
        pywrap_common_deps.append(normalized_dep_label)
        normalized_deps[normalized_dep_label] = (dep_props[0], normalized_windef_label)

    pywrap_common_name = "%s_pywrap_common" % (name)
    pywrap_split_library(
        name = pywrap_common_name,
        deps = pywrap_common_deps,
        keep_deps = True,
    )

    pywrap_common_cc_binary_name = "%s_cc_binary" % (pywrap_common_name)
    native.cc_binary(
        name = pywrap_common_cc_binary_name,
        deps = [":%s" % pywrap_common_name],
        linkstatic = True,
        linkshared = True,
        features = ["windows_export_all_symbols"],
        win_def_file = common_win_def_file,
    )

    # The following filegroup/cc_import shenanigans to extract .if.lib from
    # cc_binary should not be needed, but otherwise bazel can't consume
    # cc_binary properly as a dep in downstream cc_binary/cc_test targets.
    # I.e. cc_binary does not work as a dependency downstream, but if wrapped
    # into a cc_import it all of a sudden starts working. I wish bazel team
    # fixed it...
    pywrap_common_if_lib_name = "_%s_if_lib" % (pywrap_common_name)
    native.filegroup(
        name = pywrap_common_if_lib_name,
        srcs = [":%s" % pywrap_common_cc_binary_name],
        output_group = "interface_library",
    )

    pywrap_common_import_name = "_%s_import" % pywrap_common_name
    native.cc_import(
        name = pywrap_common_import_name,
        interface_library = ":%s" % pywrap_common_if_lib_name,
        shared_library = ":%s" % pywrap_common_cc_binary_name,
    )

    # 2) Create individual super-thin pywrap libraries, which depend on the
    # common one. The individual libraries must link in statically only the
    # object file with Python Extension's init function PyInit_<extension_name>
    #
    outputs_filegroup_win = [":%s" % pywrap_common_cc_binary_name]
    outputs_filegroup = [":%s" % pywrap_common_cc_binary_name]
    outputs_data = []

    for orig_label, lib_props in normalized_deps.items():
        pybind_lib_name = lib_props[0]
        pybind_lib_win_def_file = lib_props[1]

        pywrap_lib_name = "_%s_pywrap" % pybind_lib_name

        pywrap_split_library(
            name = pywrap_lib_name,
            deps = [orig_label],
            keep_deps = False,
        )
        native.cc_binary(
            name = pybind_lib_name,
            srcs = [],
            deps = [
                ":%s" % pywrap_lib_name,
                ":%s" % pywrap_common_import_name,
                "@pybind11//:pybind11", # why do we need it?
            ],
            linkstatic = True,
            linkshared = True,
            win_def_file = pybind_lib_win_def_file,
        )

        # The following two genrules are mutually exclusive
        # only one will be performed on each platform
        pybind_dyn_lib_file_name_win = "%s.pyd" % pybind_lib_name
        native.genrule(
            name = "_%s_dyn_lib_win" % pybind_lib_name,
            srcs = ["%s" % pybind_lib_name],
            outs = [pybind_dyn_lib_file_name_win],
            cmd = "cp $< $@;",
        )
        pybind_dyn_lib_file_name = "%s.so" % pybind_lib_name
        native.genrule(
            name = "_%s_dyn_lib" % pybind_lib_name,
            srcs = ["%s" % pybind_lib_name],
            outs = [pybind_dyn_lib_file_name],
            cmd = "cp $< $@;",
        )
        outputs_data.append(":%s" % pybind_lib_name)
        outputs_filegroup_win.append(":%s" % pybind_dyn_lib_file_name_win)
        outputs_filegroup.append(":%s" % pybind_dyn_lib_file_name)

    # 3) The output of this macro is a single filegroup, which has the single
    # common library and all thin individual wrappers (with proper
    # platform-specific file extensions) together. Ready to be added as a simple
    # "data" entry in any py_test or py_binary target down the stream.
    #
    native.filegroup(
        name = name,
        srcs = select({
            "@bazel_tools//src/conditions:windows": outputs_filegroup_win,
            "//conditions:default": outputs_filegroup
        }),
        data = outputs_data,
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

    keep_deps = ctx.attr.keep_deps;
    dependency_libraries = []

    for dep in ctx.attr.deps:
        # TODO: we should not rely on order of object files in CcInfo
        no_of_deps_extracted = 0;
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
                break;


    linker_input = cc_common.create_linker_input(
        owner = ctx.label,
        libraries = depset(direct = dependency_libraries),
    )

    linking_context = cc_common.create_linking_context(
        linker_inputs = depset(direct = [linker_input])
    )

    return [CcInfo(linking_context = linking_context)]

pywrap_split_library = rule(
    attrs = {
        "deps": attr.label_list(
            allow_files = True,
            providers = [CcInfo],
        ),
        "_cc_toolchain": attr.label(
            default = "@bazel_tools//tools/cpp:current_cc_toolchain"
        ),
        "keep_deps": attr.bool()
    },
    fragments = ["cpp"],
    toolchains = use_cpp_toolchain(),
    implementation = _pywrap_split_library_impl,
)