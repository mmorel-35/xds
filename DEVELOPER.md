# Developer documentation

## Synchronize generated files

### Option 1: Buf + Gazelle Integration (Recommended)

Run the following command to update generated files using buf and Gazelle:

```sh
tools/update_buf_and_gazelle.sh
```

This will:
1. Generate protobuf files using buf (via `tools/generate_protobuf.sh`)
2. Update BUILD files for Go packages using Gazelle
3. Update Go module dependencies

### Option 2: Buf Generation Only

For manual protobuf generation without Gazelle integration:

```sh
tools/generate_protobuf.sh
```

Or manually:

```sh
buf dep update
buf generate --template buf.gen.go.yaml
buf generate --template buf.gen.python.yaml
```

### Option 3: Legacy Bazel generation (deprecated)

The previous Bazel-based generation has been replaced. If you need to use the legacy approach:

```sh
bazel build //...
tools/generate_lang_files_from_protos.py
```

### Buf-Gazelle Integration Details

The new buf-Gazelle integration provides:

- **Modern protobuf generation**: Uses buf with remote plugins
- **Automatic BUILD file management**: Gazelle creates and updates BUILD files for generated Go files
- **Hybrid approach**: Supports both buf-generated and Bazel-generated workflows
- **Better dependency management**: Cleaner, more maintainable configuration

#### Generated Files
- **Go**: `go/` directory with all `.pb.go`, `_grpc.pb.go`, and `.pb.validate.go` files
- **Python**: `python/` directory with all `_pb2.py` files and validation support
- **BUILD files**: Automatically managed by Gazelle for Go packages

#### Build Targets
After running `tools/update_buf_and_gazelle.sh`, you can build Go packages using:

```sh
# Build a specific package
bazel build //go/xds/core/v3:core

# Build all Go packages
bazel build //go/...

# Build using legacy API build system (original protobuf targets)
bazel build //xds/core/v3:pkg_go_proto
```

#### API Build System Integration

The existing `xds_proto_package()` macro continues to work with Bazel generation.
A new `xds_proto_package_buf()` macro is available for buf-based generation.

Both approaches are supported and can coexist.

### Requirements

- [Buf CLI](https://docs.buf.build/installation) for protobuf generation
- Go 1.20+ for Go module builds
- Python 3.7+ with protobuf package for Python imports
- Bazel for build system integration

### Configuration

Protobuf generation is configured via:
- `buf.yaml` - Module configuration and dependencies
- `buf.gen.go.yaml` - Go-specific generation with remote plugins
- `buf.gen.python.yaml` - Python-specific generation with module inputs

Dependencies include:
- `buf.build/googleapis/googleapis` - Google APIs
- `buf.build/envoyproxy/protoc-gen-validate` - Validation rules
- `buf.build/google/cel-spec` - Common Expression Language
