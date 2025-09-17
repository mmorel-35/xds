# Developer documentation

## Prerequisites

### Installing Buf CLI

This repository uses [Buf](https://buf.build/) for protobuf code generation and validation. Install Buf before contributing:

**macOS:**
```sh
brew install bufbuild/buf/buf
```

**Linux/Windows:**
```sh
# Download and install from GitHub releases
curl -sSL "https://github.com/bufbuild/buf/releases/latest/download/buf-$(uname -s)-$(uname -m)" -o /usr/local/bin/buf
chmod +x /usr/local/bin/buf
```

**Verify installation:**
```sh
buf --version
```

For more installation options, see the [Buf installation guide](https://docs.buf.build/installation).

## Code generation and validation

### Synchronize generated files

Run the following command to update the generated files and commit them with your change:

```sh
# Generate protobuf files
buf generate

# Build and test
bazel build //...
bazel test //...
```

### Buf workflow

- **Generate code**: `buf generate` - Generates Go and Python protobuf files
- **Check dependencies**: `buf dep update` - Updates external proto dependencies
- **Validate protos**: `buf lint` - Validates proto file formatting and style
- **Breaking changes**: `buf breaking --against '.git#branch=main'` - Checks for breaking changes

### Development workflow

1. Make changes to proto files
2. Run `buf generate` to update generated code
3. Run tests: `bazel test //...`
4. Commit both proto changes and generated files

## Proto validation migration

This repository has been migrated from protoc-gen-validate (PGV) to protovalidate for modern validation. All proto files now use:

- **Import**: `buf/validate/validate.proto` (instead of `validate/validate.proto`)
- **Syntax**: `(buf.validate.field).string.min_len = 1` (instead of `(validate.rules).string.min_len = 1`)
- **Oneof validation**: `(buf.validate.oneof).required = true` (instead of `(validate.required) = true`)

For migration details, see the [protovalidate migration guide](https://protovalidate.com/migration-guides/migrate-from-protoc-gen-validate).

## Buf configuration

### buf.yaml (Module configuration)
- **Module name**: `github.com/cncf/xds` (for upstream compatibility)
- **Dependencies**: protovalidate, googleapis, CEL spec

### buf.gen.yaml v2 (Code generation)
- **Version**: v2 with managed mode enabled
- **Go plugin**: `buf.build/protocolbuffers/go` (remote plugin)
- **Python plugin**: `buf.build/protocolbuffers/python` (remote plugin)
- **Managed mode**: Automatic Go package prefix management

## CI integration

The CI system automatically:
1. Installs Buf CLI
2. Runs `buf generate`
3. Fails if generated files are out of date
4. Runs all Bazel tests

Contributors must ensure generated files are up to date before submitting PRs.
