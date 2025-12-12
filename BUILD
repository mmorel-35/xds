load("@rules_buf//buf:defs.bzl", "buf_lint_test")

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
