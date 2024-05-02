def _proto_srcs_impl(ctx):
    files = []
    for dep in ctx.attr.deps:
        for f in dep.files.to_list():
            if f.extension == ctx.attr.extension:
                files.append(f)

    return [DefaultInfo(files = depset(direct = files))]

proto_srcs = rule(
    attrs = {
        "deps": attr.label_list(
            allow_files = False,
            providers = [CcInfo],
        ),
        "extension": attr.string(),
    },
    implementation = _proto_srcs_impl,
)