# Use Buf for Python code generation  
# This replaces the legacy custom Bazel proto generation

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