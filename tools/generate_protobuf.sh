#!/bin/bash
# Generate protobuf files using Buf gen v2
#
# This script generates Go and Python protobuf files using Buf with remote plugins,
# providing a modern alternative to Bazel proto generation while maintaining
# full compatibility with the existing API build system.

set -e

echo "Generating protobuf files using Buf gen v2..."

# Clean up any Bazel symlinks that might interfere with buf
rm -rf bazel-*

# Add /tmp to PATH if buf is installed there
export PATH="/tmp:$PATH"

# Ensure buf is available
if ! command -v buf &> /dev/null; then
    echo "Error: buf CLI not found. Please install buf: https://docs.buf.build/installation"
    exit 1
fi

# Update dependencies to ensure latest versions
echo "Updating buf dependencies..."
buf dep update

# Generate Go protobuf files (includes validation via remote plugin)
echo "Generating Go protobuf files..."
buf generate --template buf.gen.go.yaml

# Generate Python protobuf files (includes validation via module input)
echo "Generating Python protobuf files..."
buf generate --template buf.gen.python.yaml

# Create missing __init__.py files for Python packages
echo "Creating missing __init__.py files for Python packages..."
find python -type d -exec sh -c 'for dir; do [ ! -f "$dir/__init__.py" ] && touch "$dir/__init__.py"; done' sh {} +

echo "✅ Protobuf generation complete!"
echo "Generated files:"
echo "  - Go: $(find go -name "*.pb.go" | wc -l) protobuf files"
echo "  - Go: $(find go -name "*_grpc.pb.go" | wc -l) gRPC files"  
echo "  - Go: $(find go -name "*.pb.validate.go" | wc -l) validation files"
echo "  - Python: $(find python -name "*_pb2.py" | wc -l) protobuf files"
echo ""
echo "The generated files work seamlessly with the existing Bazel build system."
echo "Use 'bazel build //xds/core/v3:pkg_go_proto' or similar targets as before."