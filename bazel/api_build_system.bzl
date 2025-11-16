"""
DEPRECATED: This file is deprecated and maintained only for backward compatibility.

New code should import rules directly from their isolated files instead:
- Use //bazel:xds_proto_package.bzl for xds_proto_package and udpa_proto_package
- Use //bazel:xds_cc_test.bzl for xds_cc_test and udpa_cc_test
- Use //bazel:xds_go_test.bzl for xds_go_test and udpa_go_test

This file re-exports all rules from the isolated rule files to maintain backward
compatibility with existing BUILD files. Please migrate to the specific rule files
for better modularity and to follow Bazel best practices.
"""

load(
    "//bazel:xds_proto_package.bzl",
    _udpa_proto_package = "udpa_proto_package",
    _xds_proto_package = "xds_proto_package",
)
load(
    "//bazel:xds_cc_test.bzl",
    _udpa_cc_test = "udpa_cc_test",
    _xds_cc_test = "xds_cc_test",
)
load(
    "//bazel:xds_go_test.bzl",
    _udpa_go_test = "udpa_go_test",
    _xds_go_test = "xds_go_test",
)

# Re-export all rules for backward compatibility
# DEPRECATED: Import these rules directly from their respective files instead:
#   - xds_proto_package and udpa_proto_package from //bazel:xds_proto_package.bzl
#   - xds_cc_test and udpa_cc_test from //bazel:xds_cc_test.bzl
#   - xds_go_test and udpa_go_test from //bazel:xds_go_test.bzl
xds_proto_package = _xds_proto_package
xds_cc_test = _xds_cc_test
xds_go_test = _xds_go_test
udpa_proto_package = _udpa_proto_package
udpa_cc_test = _udpa_cc_test
udpa_go_test = _udpa_go_test

