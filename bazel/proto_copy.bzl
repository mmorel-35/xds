"""Helper rules to copy generated proto files to source tree using Bazel-native approach.

This replaces the custom Python script (tools/generate_lang_files_from_protos.py) with
Bazel-native rules using aspect_bazel_lib's write_source_files.
"""

load("@aspect_bazel_lib//lib:write_source_files.bzl", "write_source_files")
load("@aspect_bazel_lib//lib:copy_to_directory.bzl", "copy_to_directory")

def copy_proto_generated_files(name, go_proto_targets, py_proto_targets):
    """
    Creates rules to copy all generated proto files to the source tree for both Go and Python.
    
    This is a Bazel-native replacement for the custom Python script approach.
    
    Args:
        name: Base name for the rules
        go_proto_targets: List of go_proto_library targets (e.g., ["//xds/core/v3:pkg_go_proto"])
        py_proto_targets: List of py_proto_library targets (e.g., ["//xds/core/v3:pkg_py_proto"])
    """
    
    # Process Go proto targets
    for target in go_proto_targets:
        # Extract package path like "xds/core/v3" from "//xds/core/v3:pkg_go_proto"
        package_path = target.split("//")[1].split(":")[0]
        target_name = package_path.replace("/", "_")
        
        # Create filegroup with generated Go sources
        native.filegroup(
            name = name + "_go_" + target_name + "_srcs",
            srcs = [target],
            output_group = "go_generated_srcs",
        )
        
        # Copy to directory, flattening the nested structure
        copy_to_directory(
            name = name + "_go_" + target_name + "_dir",
            srcs = [":" + name + "_go_" + target_name + "_srcs"],
            root_paths = ["github.com/cncf/xds/go/" + package_path],
            out = name + "_go_" + target_name,
        )
    
    # Process Python proto targets  
    for target in py_proto_targets:
        # Extract package path
        package_path = target.split("//")[1].split(":")[0]
        target_name = package_path.replace("/", "_")
        
        # For Python, just get the _pb2.py files
        native.filegroup(
            name = name + "_py_" + target_name + "_srcs",
            srcs = [target],
        )
        
        # Copy Python files (they're already flat in bazel-bin)
        copy_to_directory(
            name = name + "_py_" + target_name + "_dir",
            srcs = [":" + name + "_py_" + target_name + "_srcs"],
            include_external_repositories = [],  # Only include files from this repo
            out = name + "_py_" + target_name,
        )
