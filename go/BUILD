# Buf-based Go code generation
# Use: bazel build //go:generate_go to trigger Go proto generation
# Generated files will be placed in go/ directory

sh_binary(
    name = "generate_go",
    srcs = ["//tools:buf_generate.sh"],
    data = [
        "//:buf.gen.yaml",
        "//:buf.yaml",
    ],
    visibility = ["//visibility:public"],
)

# Alias for backward compatibility
alias(
    name = "go",
    actual = ":generate_go", 
    visibility = ["//visibility:public"],
)

# Documentation target
filegroup(
    name = "README",
    srcs = [],
    visibility = ["//visibility:public"],
)
