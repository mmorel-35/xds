# Buf Integration Guide

This repository uses [Buf](https://buf.build/) for protobuf code generation and validation.

## Quick Start

1. **Install Buf CLI**:
   ```bash
   # macOS
   brew install bufbuild/buf/buf
   
   # Linux/Windows
   curl -sSL "https://github.com/bufbuild/buf/releases/latest/download/buf-$(uname -s)-$(uname -m)" -o /usr/local/bin/buf
   chmod +x /usr/local/bin/buf
   ```

2. **Generate protobuf files**:
   ```bash
   # From repository root
   buf generate
   
   # Or use the helper script
   tools/buf_generate.sh
   ```

## Configuration Files

- **`buf.yaml`**: Module configuration with dependencies
- **`buf.gen.yaml`**: Code generation configuration (v2 format)
- **`buf.lock`**: Dependency lock file (auto-generated)

## Generated Files

- **Go**: `go/` directory with `.pb.go` files
- **Python**: `python/` directory with `_pb2.py` files

## CI Integration

The CI system automatically:
- Installs Buf CLI
- Generates protobuf files
- Fails if generated files are out of date

## Migration Notes

This repository has been migrated from:
- **protoc-gen-validate (PGV)** → **protovalidate**
- **Custom Bazel generation** → **Buf v2 with remote plugins**
- **Local toolchain dependencies** → **Remote plugin infrastructure**

For more details, see `DEVELOPER.md`.