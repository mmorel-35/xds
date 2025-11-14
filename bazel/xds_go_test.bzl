"""xDS go_test rules"""

load("@io_bazel_rules_go//go:def.bzl", "go_test")

def xds_go_test(name, **kwargs):
    go_test(
        name = name,
        **kwargs
    )

# Old name for backward compatibility.
# TODO(roth): Remove this once all callers are migrated to the new name.
def udpa_go_test(name, **kwargs):
    xds_go_test(name, **kwargs)
