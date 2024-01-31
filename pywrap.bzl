load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain", "use_cpp_toolchain")

PywrapInfo = provider(
    fields = {
        "cc_info": "Wrapped CcInfo",
        "owner": "Owner's label",
    }
)

CollectedPywrapInfo = provider(
    fields = {
        "pywrap_infos": "depset of PywrapInfo providers"
    }
)

def pywrap_library(
        name,
        deps,
        win_def_file = None,
        pywrap_count = 1,
        extra_deps = ["@pybind11//:pybind11"],
        # For demonstration purposes only.
        # For real work we always want:
        #   generate_common_lib = True
        # as it is the whole point of pywrap_extension
        generate_common_lib = True):

    # 1) Create common pywrap library. The common library should link in
    # everything except the object file with Python Extension's init function
    # PyInit_<extension_name>.
    #
    pywrap_info_collector_name = "_%s_info_collector" % (name)

    collected_pywrap_infos(
        name = pywrap_info_collector_name,
        deps = deps,
        pywrap_count = pywrap_count,
    )

    pywrap_common_name = "_%s_pywrap_common" % (name)
    _pywrap_split_library(
        name = pywrap_common_name,
        dep = ":%s" % pywrap_info_collector_name,
        pywrap_index = -1,
    )

    common_deps = []

    if generate_common_lib:
        pywrap_common_cc_binary_name = "%s_common" % (name)

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
        common_deps.append(":%s" % pywrap_common_import_name)

    # 2) Create individual super-thin pywrap libraries, which depend on the
    # common one. The individual libraries must link in statically only the
    # object file with Python Extension's init function PyInit_<extension_name>
    #
    shared_objects = []
    common_deps.extend(extra_deps)

    for pywrap_index in range(0, pywrap_count):
        dep_name = "_%s_%s" % (name, pywrap_index)
        shared_object_name = "%s_shared_object" % dep_name
        win_def_name = "%s_win_def" % dep_name
        pywrap_name = "%s_pywrap" % dep_name

        if generate_common_lib:
            _pywrap_split_library(
                name = pywrap_name,
                dep = ":%s" % pywrap_info_collector_name,
                pywrap_index = pywrap_index,
            )
        else:
            pywrap_name = "_%s_cc_library" % Label(deps[pywrap_index]).name

        _generated_win_def_file(
            name = win_def_name,
            dep = ":%s" % pywrap_info_collector_name,
            pywrap_index = pywrap_index,
        )

        native.cc_binary(
            name = shared_object_name,
            srcs = [],
            deps = [":%s" % pywrap_name] + common_deps,
            linkshared = True,
            linkstatic = generate_common_lib,
            win_def_file = ":%s" % win_def_name,
        )
        shared_objects.append(":%s" % shared_object_name)


    # 3) Construct final binaries with proper names and put them as data
    # attribute in a py_library, which is the final and only public artifact of
    # this macro
    #
    pywrap_binaries_name = "_%s_binaries" % name
    _pywrap_binaries(
        name = pywrap_binaries_name,
        collected_pywraps = ":%s" % pywrap_info_collector_name,
        deps = shared_objects,
        extension = select({
            "@bazel_tools//src/conditions:windows": ".pyd",
            "//conditions:default": ".so",
        })
     )

    binaries_data = ["%s" % pywrap_binaries_name] + shared_objects
    if generate_common_lib:
        binaries_data.append(":%s" % pywrap_common_cc_binary_name)


    native.py_library(
        name = name,
        srcs = [],
        data = binaries_data,
    )

    if generate_common_lib:
        gen_pywrap_win_def_file = "%s_gen_def" % pywrap_common_name
        _generated_pywrap_win_def_file(
            name = gen_pywrap_win_def_file,
            dep = ":%s" % pywrap_info_collector_name,
            pywrap_index = -1,
        )
        native.cc_binary(
            name = pywrap_common_cc_binary_name,
            deps = [":%s" % pywrap_common_name],
            linkstatic = True,
            linkshared = True,
            win_def_file = gen_pywrap_win_def_file,
        )

def pybind_extension(
        name,
        srcs,
        deps,
        win_def_file = None,
        **kwargs):
    cc_library_name = "_%s_cc_library" % name

    native.cc_library(
        name = cc_library_name,
        deps = deps + ["@pybind11//:pybind11"],
        srcs = srcs,
        linkstatic = True,
        alwayslink = True,
        **kwargs
    )

    _pywrap_info_wrapper(
        name = name,
        deps = ["%s" % cc_library_name],
    )

def _generated_pywrap_win_def_file_impl(ctx):
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    dependency_libraries = []

    pywrap_index = ctx.attr.pywrap_index
    pywrap_infos = ctx.attr.dep[CollectedPywrapInfo].pywrap_infos.to_list()
    if pywrap_index >= 0:
        pywrap_infos = [pywrap_infos[pywrap_index]]

    for pywrap_info in pywrap_infos:
        cc_info = pywrap_info.cc_info

        linker_inputs = cc_info.linking_context.linker_inputs.to_list()
        
        for linker_input in linker_inputs:
            for lib in linker_input.libraries:
                lib_copy = lib;
                if not lib.alwayslink:
                    lib_copy = cc_common.create_library_to_link(
                        actions = ctx.actions,
                        cc_toolchain = cc_toolchain,
                        feature_configuration = feature_configuration,
                        static_library = lib.static_library,
                        pic_static_library = lib.pic_static_library,
                        interface_library = lib.interface_library,
                        alwayslink = True,
                    )
                if lib_copy.objects:
                    dependency_libraries.append(lib_copy)

    pywrap_infos = ctx.attr.dep[CollectedPywrapInfo].pywrap_infos.to_list()
    pywrap_info = pywrap_infos[ctx.attr.pywrap_index]
    win_def_file_name = "%s.gen.def" % pywrap_info.owner.name
    win_def_file = ctx.actions.declare_file(win_def_file_name)
    print("win_def_file.path:", win_def_file.path)
    print("dependency_libraries[0][static_library].path:", dependency_libraries[0].static_library.path)
    ctx.actions.run_shell(
        inputs = [dependency_library.static_library for dependency_library in dependency_libraries],
        # command = "echo \"EXPORTS\r\n\t?first_func@@YAHH@Z\r\n\t?second_func@@YAHH@Z\r\n\">> {win_def_file}".format(
        command = "echo \"EXPORTS\r\n\">> {win_def_file} && \"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\bin\\Hostx86\\x86\\dumpbin.exe\" //SYMBOLS {dependency_library} | grep 'UNDEF' | grep 'External' | grep '()' | cut -d\" \" -f16 | grep '\\?[a-zA-Z]\\+.*'>> {win_def_file}".format(
            # dependency_library = "bazel-out/x64_windows-opt/bin/pybind/_pybind_cc_library.lo.lib",
            # dependency_library = "bazel-out/x64_windows-opt/bin/pybind/_objs/_pybind_cc_library/pybind.obj",
            dependency_library = " ".join([l.static_library.path for l in dependency_libraries]),
            win_def_file = win_def_file.path,
        ),
        outputs = [win_def_file],
    )

    return [DefaultInfo(files = depset(direct = [win_def_file]))]

_generated_pywrap_win_def_file = rule(
    attrs = {
        "dep": attr.label(
            allow_files = False,
            providers = [CollectedPywrapInfo],
        ),
        "_cc_toolchain": attr.label(
            default = "@bazel_tools//tools/cpp:current_cc_toolchain",
        ),
        "pywrap_index": attr.int(mandatory = True, default = -1),
    },
    fragments = ["cpp"],
    toolchains = use_cpp_toolchain(),
    implementation = _generated_pywrap_win_def_file_impl,
)

def _generated_win_def_file_impl(ctx):
    pywrap_infos = ctx.attr.dep[CollectedPywrapInfo].pywrap_infos.to_list()
    pywrap_info = pywrap_infos[ctx.attr.pywrap_index]
    win_def_file_name = "%s.def" % pywrap_info.owner.name
    win_def_file = ctx.actions.declare_file(win_def_file_name)
    ctx.actions.run_shell(
        inputs = [],
        command = "echo \"EXPORTS\r\n  PyInit_{owner}\">> {win_def_file}".format(
            owner = pywrap_info.owner.name,
            win_def_file = win_def_file.path
        ),
        outputs = [win_def_file],
    )

    return [DefaultInfo(files = depset(direct = [win_def_file]))]

_generated_win_def_file = rule(
    attrs = {
        "dep": attr.label(
            allow_files = False,
            providers = [CollectedPywrapInfo],
        ),
        "pywrap_index": attr.int(mandatory = True),
    },
    implementation = _generated_win_def_file_impl,
)


def _pywrap_split_library_impl(ctx):
    cc_toolchain = find_cpp_toolchain(ctx)
    feature_configuration = cc_common.configure_features(
        ctx = ctx,
        cc_toolchain = cc_toolchain,
        requested_features = ctx.features,
        unsupported_features = ctx.disabled_features,
    )

    dependency_libraries = []

    pywrap_index = ctx.attr.pywrap_index
    pywrap_infos = ctx.attr.dep[CollectedPywrapInfo].pywrap_infos.to_list()
    if pywrap_index >= 0:
        pywrap_infos = [pywrap_infos[pywrap_index]]

    for pywrap_info in pywrap_infos:
        cc_info = pywrap_info.cc_info
        # TODO: we should not rely on order of object files in CcInfo
        if pywrap_index >= 0:
            linker_inputs = cc_info.linking_context.linker_inputs.to_list()[:1]
        else:
            linker_inputs = cc_info.linking_context.linker_inputs.to_list()[1:]

        for linker_input in linker_inputs:
            for lib in linker_input.libraries:
                lib_copy = lib;
                if not lib.alwayslink:
                    lib_copy = cc_common.create_library_to_link(
                        actions = ctx.actions,
                        cc_toolchain = cc_toolchain,
                        feature_configuration = feature_configuration,
                        static_library = lib.static_library,
                        pic_static_library = lib.pic_static_library,
                        interface_library = lib.interface_library,
                        alwayslink = True,
                    )
                dependency_libraries.append(lib_copy)

    linker_input = cc_common.create_linker_input(
        owner = ctx.label,
        libraries = depset(direct = dependency_libraries),
    )

    linking_context = cc_common.create_linking_context(
        linker_inputs = depset(direct = [linker_input]),
    )

    return [CcInfo(linking_context = linking_context)]

_pywrap_split_library = rule(
    attrs = {
        "dep": attr.label(
            allow_files = False,
            providers = [CollectedPywrapInfo],
        ),
        "_cc_toolchain": attr.label(
            default = "@bazel_tools//tools/cpp:current_cc_toolchain",
        ),
        "pywrap_index": attr.int(mandatory = True, default = -1),
    },
    fragments = ["cpp"],
    toolchains = use_cpp_toolchain(),
    implementation = _pywrap_split_library_impl,
)

def _pywrap_info_wrapper_impl(ctx):
    #the attribute is called deps not dep to match aspect's attr_aspects
    if len(ctx.attr.deps) != 1:
        fail("deps attribute must contain exactly one dependency")

    wrapped_dep = ctx.attr.deps[0]
    return [
        PyInfo(transitive_sources = depset()),
        PywrapInfo(
            cc_info = wrapped_dep[CcInfo],
            owner = ctx.label,
        ),
    ]

_pywrap_info_wrapper = rule(
    attrs = {
        "deps": attr.label_list(providers = [CcInfo]),
    },

    implementation = _pywrap_info_wrapper_impl
)

def _pywrap_info_collector_aspect_impl(target, ctx):
    cc_infos = []
    transitive_cc_infos = []
    pywrap_infos = []
    transitive_pywrap_infos = []
    if PywrapInfo in target:
        pywrap_infos.append(target[PywrapInfo])

    if hasattr(ctx.rule.attr, "deps"):
        for dep in ctx.rule.attr.deps:
            if CollectedPywrapInfo in dep:
                collected_pywrap_info = dep[CollectedPywrapInfo]
                transitive_pywrap_infos.append(collected_pywrap_info.pywrap_infos)

    return [
        CollectedPywrapInfo(
            pywrap_infos = depset(
                direct = pywrap_infos,
                transitive = transitive_pywrap_infos,
                order = "topological"
            ),
        )
    ]

_pywrap_info_collector_aspect = aspect(
    attr_aspects = ["deps"],
    implementation = _pywrap_info_collector_aspect_impl
)

def _collected_pywrap_infos_impl(ctx):
    pywrap_infos = []
    for dep in ctx.attr.deps:
        if CollectedPywrapInfo in dep:
            pywrap_infos.append(dep[CollectedPywrapInfo].pywrap_infos)

    rv = CollectedPywrapInfo(pywrap_infos = depset(transitive = pywrap_infos, order = "topological"))
    pywraps = rv.pywrap_infos.to_list();

    if ctx.attr.pywrap_count != len(pywraps):
        found_pywraps = "\n        ".join([str(pw.owner) for pw in pywraps])
        fail("""
    Number of actual pywrap libraries does not match expected pywrap_count.
    Expected pywrap_count: {expected_pywrap_count}
    Actual pywrap_count: {actual_pywra_count}
    Actual pywrap libraries in the transitive closure of {label}:
        {found_pywraps}
    """.format(expected_pywrap_count = ctx.attr.pywrap_count,
               actual_pywra_count = len(pywraps),
               label = ctx.label,
               found_pywraps = found_pywraps))

    return [rv]

collected_pywrap_infos = rule(
    attrs = {
        "deps": attr.label_list(
            aspects = [_pywrap_info_collector_aspect],
            providers = [PyInfo]
        ),
        "pywrap_count": attr.int(mandatory = True, default = 1),
    },

    implementation = _collected_pywrap_infos_impl
)

def _pywrap_binaries_impl(ctx):
    deps = ctx.attr.deps
    dep = ctx.attr.collected_pywraps
    extension = ctx.attr.extension

    pywrap_infos = dep[CollectedPywrapInfo].pywrap_infos.to_list()
    original_binaries = deps

    if len(pywrap_infos) != len(original_binaries):
        fail()

    final_binaries = []
    for i in range(0, len(pywrap_infos)):
        pywrap_info = pywrap_infos[i]
        original_binary = original_binaries[i]
        final_binary_name = "%s%s" % (pywrap_info.owner.name, extension)
        final_binary = ctx.actions.declare_file(final_binary_name)
        original_binary_file = original_binary.files.to_list()[0]
        ctx.actions.run_shell(
            inputs = [original_binary_file],
            command = "cp {original} {final}".format(
                original = original_binary_file.path,
                final = final_binary.path
            ),
            outputs = [final_binary],
        )

        final_binaries.append(final_binary)

    return [DefaultInfo(files = depset(direct = final_binaries))]


_pywrap_binaries = rule(
    attrs = {
        "deps": attr.label_list(mandatory = True, allow_files = False),
        "collected_pywraps": attr.label(mandatory = True, allow_files = False),
        "extension": attr.string(default = ".so"),
    },

    implementation = _pywrap_binaries_impl
)
