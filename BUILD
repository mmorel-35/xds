"""Build rules to copy generated proto files to source tree.

This file contains Bazel-native rules to replace the custom Python script
(tools/generate_lang_files_from_protos.py) for copying generated proto files.

Usage:
    # To update Go and Python proto files:
    bazel run //:update_protos
"""

load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_files")
load("@aspect_bazel_lib//lib:copy_to_directory.bzl", "copy_to_directory")

# List of all go_proto_library targets
GO_PROTO_TARGETS = [
    ("//udpa/annotations:pkg_go_proto", "udpa/annotations"),
    ("//udpa/data/orca/v1:pkg_go_proto", "udpa/data/orca/v1"),
    ("//udpa/service/orca/v1:pkg_go_proto", "udpa/service/orca/v1"),
    ("//udpa/type/v1:pkg_go_proto", "udpa/type/v1"),
    ("//xds/annotations/v3:pkg_go_proto", "xds/annotations/v3"),
    ("//xds/core/v3:pkg_go_proto", "xds/core/v3"),
    ("//xds/data/orca/v3:pkg_go_proto", "xds/data/orca/v3"),
    ("//xds/service/orca/v3:pkg_go_proto", "xds/service/orca/v3"),
    ("//xds/type/matcher/v3:pkg_go_proto", "xds/type/matcher/v3"),
    ("//xds/type/v3:pkg_go_proto", "xds/type/v3"),
]

# List of all py_proto_library targets  
PY_PROTO_TARGETS = [
    ("//udpa/annotations:pkg_py_proto", "udpa/annotations"),
    ("//udpa/data/orca/v1:pkg_py_proto", "udpa/data/orca/v1"),
    ("//udpa/service/orca/v1:pkg_py_proto", "udpa/service/orca/v1"),
    ("//udpa/type/v1:pkg_py_proto", "udpa/type/v1"),
    ("//xds/annotations/v3:pkg_py_proto", "xds/annotations/v3"),
    ("//xds/core/v3:pkg_py_proto", "xds/core/v3"),
    ("//xds/data/orca/v3:pkg_py_proto", "xds/data/orca/v3"),
    ("//xds/service/orca/v3:pkg_py_proto", "xds/service/orca/v3"),
    ("//xds/type/matcher/v3:pkg_py_proto", "xds/type/matcher/v3"),
    ("//xds/type/v3:pkg_py_proto", "xds/type/v3"),
]

# Create rules for each Go proto target
[
    filegroup(
        name = "go_srcs_" + pkg.replace("/", "_"),
        srcs = [target],
        output_group = "go_generated_srcs",
    )
    for target, pkg in GO_PROTO_TARGETS
]

[
    copy_to_directory(
        name = "go_dir_" + pkg.replace("/", "_"),
        srcs = [":go_srcs_" + pkg.replace("/", "_")],
        root_paths = [pkg + "/pkg_go_proto_/github.com/cncf/xds"],
    )
    for target, pkg in GO_PROTO_TARGETS
]

# Merge all Go directories properly
# Each go_dir contains: go/{package}/*.go
# We want the final structure to be: {package}/*.go (without the "go/" prefix)
# So we strip both the intermediate directory names AND the "go/" prefix
copy_to_directory(
    name = "all_go_merged",
    srcs = [":go_dir_" + pkg.replace("/", "_") for target, pkg in GO_PROTO_TARGETS] + [
        "//go:BUILD",
        "//go:go.mod",
        "//go:go.sum",
    ],
    root_paths = ["go"],
    replace_prefixes = dict(
        [("go_dir_" + pkg.replace("/", "_") + "/go", "")
         for target, pkg in GO_PROTO_TARGETS] +
        [("_dir_" + pkg.replace("/", "_"), pkg.replace("_", "/"))
         for target, pkg in GO_PROTO_TARGETS]
    ),
    include_external_repositories = [],
)

write_source_files(
    name = "update_go_protos",
    files = {
        "go": ":all_go_merged",
    },
)

# Create rules for each Python proto target
[
    filegroup(
        name = "py_srcs_" + pkg.replace("/", "_"),
        srcs = [target],
    )
    for target, pkg in PY_PROTO_TARGETS
]

[
    genrule(
        name = "py_filter_" + pkg.replace("/", "_"),
        srcs = [":py_srcs_" + pkg.replace("/", "_")],
        outs = ["py_filtered_" + pkg.replace("/", "_")],
        cmd = """
            mkdir -p $@
            for f in $(SRCS); do
                # Only copy _pb2.py files from the specific package directory
                if [[ "$$f" == *"{pkg}/"*"_pb2.py" ]] && [[ "$$f" != *"/external/"* ]]; then
                    cp "$$f" "$@/"
                fi
            done
        """.format(pkg = pkg),
    )
    for target, pkg in PY_PROTO_TARGETS
]

# Merge all Python directories
copy_to_directory(
    name = "all_py_merged",
    srcs = [":py_filter_" + pkg.replace("/", "_") for target, pkg in PY_PROTO_TARGETS],
    include_external_repositories = [],
)

write_source_files(
    name = "update_py_protos",
    files = {
        "python": ":all_py_merged",
    },
)

# Combined target to update all protos
alias(
    name = "update_protos",
    actual = ":update_go_protos",
)
