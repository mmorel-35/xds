load("@rules_buf//buf:defs.bzl", "buf_breaking_test", "buf_format", "buf_lint_test")

# Buf configuration files
exports_files([
    "buf.yaml",
    "buf.lock",
])

# Buf lint test for the entire repository
buf_lint_test(
    name = "buf_lint_test",
    config = ":buf.yaml",
    targets = [
        "//udpa/annotations:pkg",
        "//udpa/data/orca/v1:pkg",
        "//udpa/service/orca/v1:pkg",
        "//udpa/type/v1:pkg",
        "//xds/annotations/v3:pkg",
        "//xds/core/v3:pkg",
        "//xds/data/orca/v3:pkg",
        "//xds/service/orca/v3:pkg",
        "//xds/type/v3:pkg",
        "//xds/type/matcher/v3:pkg",
    ],
)

# Buf format rule - run with: bazel run //:buf_format
# This formats all proto files in the workspace
buf_format(
    name = "buf_format",
)

# Buf breaking change detection
# To enable buf_breaking_test for a proto package, add the breaking_against parameter
# to xds_proto_package() or udpa_proto_package() in your BUILD file.
# Example:
#   xds_proto_package(
#       breaking_against = "//path/to:baseline_image.binpb",
#   )
#
# To create a baseline image file, use:
#   bazel build //your/package:pkg
#   bazel run @rules_buf//tools:buf -- build -o baseline_image.binpb
#
# For more information, see: https://buf.build/docs/build-systems/bazel/#buf-breaking-test
