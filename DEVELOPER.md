# Developer documentation

## Synchronize generated files

The project now uses Buf for protobuf code generation instead of Bazel. To update the generated Go and Python files, run:

```sh
tools/generate_protobuf.sh
```

Or manually:

```sh
buf dep update
buf generate
```

### Legacy Bazel generation (deprecated)

The previous Bazel-based generation has been replaced. If you need to use the legacy approach:

```sh
bazel build //...
tools/generate_lang_files_from_protos.py
```

### Requirements

- [Buf CLI](https://docs.buf.build/installation) for protobuf generation
- Go 1.20+ for Go module builds
- Python 3.7+ with protobuf package for Python imports

### Configuration

Protobuf generation is configured via:
- `buf.yaml` - Module configuration and dependencies
- `buf.gen.yaml` - Code generation plugins and options

Dependencies include:
- `buf.build/googleapis/googleapis` - Google APIs
- `buf.build/envoyproxy/protoc-gen-validate` - Validation rules
- `buf.build/google/cel-spec` - Common Expression Language
