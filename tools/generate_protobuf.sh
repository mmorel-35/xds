#!/bin/bash
# Buf protobuf generation script
# Replaces the Bazel-based proto generation for Go and Python

set -e

echo "Generating protobuf files using Buf..."

# Ensure buf is available
if ! command -v buf &> /dev/null; then
    echo "Error: buf CLI not found. Please install buf: https://docs.buf.build/installation"
    exit 1
fi

# Ensure protoc-gen-validate is available
if ! command -v protoc-gen-validate &> /dev/null; then
    echo "protoc-gen-validate not found in PATH. Installing..."
    go install github.com/envoyproxy/protoc-gen-validate@v1.0.4
fi

# Add Go bin to PATH for local plugins
export PATH="$HOME/go/bin:$PATH"

# Update dependencies
echo "Updating Buf dependencies..."
buf dep update

# Generate protobuf files
echo "Generating Go and Python protobuf files (including UDPA)..."
buf generate

# Setup Python package structure
echo "Setting up Python package structure..."
find python -type d -exec touch {}/__init__.py \;

# Ensure Python validate package is properly structured
mkdir -p python/validate
if [ ! -f python/validate/__init__.py ]; then
    touch python/validate/__init__.py
fi

# Generate validate_pb2.py for Python if missing
if [ ! -f python/validate/validate_pb2.py ]; then
    echo "Generating validate_pb2.py for Python..."
    buf export buf.build/envoyproxy/protoc-gen-validate --output /tmp/validate_export
    if command -v protoc &> /dev/null; then
        protoc --python_out=python /tmp/validate_export/validate/validate.proto
    else
        echo "Warning: protoc not available. Manually copy validate_pb2.py if needed."
    fi
    rm -rf /tmp/validate_export
fi

echo "Protobuf generation completed successfully!"
echo ""
echo "Generated files:"
echo "  Go:     $(find go -name "*.go" | wc -l) files in go/ (includes XDS and UDPA)"
echo "  Python: $(find python -name "*.py" | wc -l) files in python/ (includes XDS and UDPA)"
echo ""
echo "Includes:"
echo "  - Standard protobuf files (.pb.go, _pb2.py)"
echo "  - gRPC service files (_grpc.pb.go)"
echo "  - Validation files (.pb.validate.go for Go)"
echo "  - UDPA protobuf files (both XDS and UDPA packages)"