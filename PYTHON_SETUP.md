# Python Setup for xds

## Overview

This document describes the Python toolchain configuration for both bzlmod and WORKSPACE build modes.

## Configuration

### Bzlmod (MODULE.bazel)

Python toolchain is configured using the `python` extension from `rules_python`:

```starlark
bazel_dep(name = "rules_python", version = "0.25.0")

# Configure Python toolchain for bzlmod
python = use_extension("@rules_python//python/extensions:python.bzl", "python")
python.toolchain(
    python_version = "3.11",
)
```

### WORKSPACE

Python toolchain is initialized in `bazel/dependency_imports.bzl`:

```starlark
load("@rules_python//python:repositories.bzl", "py_repositories", "python_register_toolchains")

PYTHON_VERSION = "3.11"

def xds_dependency_imports(go_version = GO_VERSION):
    # ... other dependencies ...
    
    # Initialize rules_python for WORKSPACE mode
    py_repositories()
    python_register_toolchains(
        name = "python_3_11",
        python_version = PYTHON_VERSION,
    )
```

## Python Version

The project is configured to use **Python 3.11** by default. This version is set consistently across both build modes.

## Python Proto Library

The project uses gRPC's `py_proto_library` implementation from `@com_github_grpc_grpc//bazel:python_rules.bzl`. This generates Python protobuf code for all proto files.

### Deprecation Warning

Note: There is a deprecation warning from protobuf's internal use of an old `py_proto_library` macro:

```
The py_proto_library macro is deprecated and will be removed in the 30.x release. 
switch to the rule defined by rules_python or the one in bazel/py_proto_library.bzl.
```

This warning comes from protobuf's own internal build files (protobuf.bzl:650) and is not caused by our project code. The project currently uses gRPC's py_proto_library implementation which works correctly with `rules_python`.

## Toolchain Precedence

With the current configuration:
- In bzlmod mode: The xds module's Python 3.11 toolchain takes precedence over those from grpc, protobuf, and other dependencies
- In WORKSPACE mode: The explicitly registered Python 3.11 toolchain is used

You will see warnings like:
```
WARNING: Ignoring toolchain 'python_3_11' from module 'grpc': 
Toolchain 'python_3_11' from module 'xds' already registered Python version 3.11 and has precedence
```

This is expected and indicates that our configuration is working correctly.

## Testing

To test Python proto generation:

```bash
# Build a single Python proto target
bazel build //xds/annotations/v3:pkg_py_proto

# Build all Python proto targets
bazel query "kind('py_.*', //...)" | xargs bazel build

# Generate Python files using the generation script
python3 tools/generate_lang_files_from_protos.py
```

## Known Limitations

1. **WORKSPACE full build**: The full `bazel build --noenable_bzlmod //...` has issues with Go dependencies (unrelated to Python setup). Individual targets build successfully.

2. **Protobuf py_proto_library**: The new protobuf `py_proto_library` from `@com_google_protobuf//bazel:py_proto_library.bzl` cannot be used directly because it has strict path validation that rejects paths containing '-' (such as in external repository names like `protoc-gen-validate~`). The gRPC implementation works around this limitation.

## Migration Notes

If migrating to protobuf's py_proto_library in the future:
- All external dependencies with '-' in their paths would need to be addressed
- The validate.proto from protoc-gen-validate is particularly problematic
- Consider using Python proto libraries from pypi for well-known protos instead of generating them
