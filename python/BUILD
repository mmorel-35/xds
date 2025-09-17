# Buf-based Python code generation
# Use: bazel build //python:generate_python to trigger Python proto generation
# Generated files will be placed in python/ directory

sh_binary(
    name = "generate_python",
    srcs = ["//tools:buf_generate.sh"],
    data = [
        "//:buf.gen.yaml",
        "//:buf.yaml",
    ],
    visibility = ["//visibility:public"],
)

# Alias for backward compatibility
alias(
    name = "python",
    actual = ":generate_python",
    visibility = ["//visibility:public"],
)

# Documentation target
filegroup(
    name = "README",
    srcs = [],
    visibility = ["//visibility:public"],
)