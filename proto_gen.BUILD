"""Build rules for generating and copying proto files to source tree.

This provides a Bazel-native alternative to tools/generate_lang_files_from_protos.py
"""

load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_files")
load("@aspect_bazel_lib//lib:copy_to_directory.bzl", "copy_to_directory")

#
# Go proto generation rules
#

# xds/core/v3
filegroup(
    name = "go_xds_core_v3_srcs",
    srcs = ["//xds/core/v3:pkg_go_proto"],
    output_group = "go_generated_srcs",
)

copy_to_directory(
    name = "go_xds_core_v3_dir",
    srcs = [":go_xds_core_v3_srcs"],
    root_paths = ["xds/core/v3/pkg_go_proto_/github.com/cncf/xds"],
)

write_source_files(
    name = "go_xds_core_v3",
    files = {
        "go": ":go_xds_core_v3_dir",
    },
)

# Python proto generation rules
filegroup(
    name = "py_xds_core_v3_srcs",
    srcs = ["//xds/core/v3:pkg_py_proto"],
)

# Filter to only local proto files, not dependencies
genrule(
    name = "py_xds_core_v3_filter",
    srcs = [":py_xds_core_v3_srcs"],
    outs = ["py_xds_core_v3_filtered"],
    cmd = """
        mkdir -p $@
        for f in $(SRCS); do
            # Only copy _pb2.py files from xds/core/v3 directory
            if [[ "$$f" == *"xds/core/v3/"*"_pb2.py" ]] && [[ "$$f" != *"/external/"* ]]; then
                cp "$$f" "$@/"
            fi
        done
    """,
)

write_source_files(
    name = "py_xds_core_v3",
    files = {
        "python": ":py_xds_core_v3_filter",
    },
)

# Aggregate target to update all protos
filegroup(
    name = "update_all_protos",
    srcs = [
        ":go_xds_core_v3",
        ":py_xds_core_v3",
    ],
)
