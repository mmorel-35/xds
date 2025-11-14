"""
api_build_system provides legacy support for backward compatibility.

This file re-exports all rules from isolated rule files to maintain backward compatibility
with existing BUILD files. New code should prefer importing from the specific rule files:
- //bazel:xds_proto_package.bzl for xds_proto_package and udpa_proto_package
- //bazel:xds_cc_test.bzl for xds_cc_test and udpa_cc_test
- //bazel:xds_go_test.bzl for xds_go_test and udpa_go_test
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
xds_proto_package = _xds_proto_package
xds_cc_test = _xds_cc_test
xds_go_test = _xds_go_test
udpa_proto_package = _udpa_proto_package
udpa_cc_test = _udpa_cc_test
udpa_go_test = _udpa_go_test

