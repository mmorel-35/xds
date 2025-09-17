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

# Update dependencies
echo "Updating Buf dependencies..."
buf dep update

# Generate protobuf files
echo "Generating Go and Python protobuf files..."
buf generate

echo "Protobuf generation completed successfully!"
echo ""
echo "Generated files:"
echo "  Go:     $(find go -name "*.go" | wc -l) files in go/"
echo "  Python: $(find python -name "*.py" | wc -l) files in python/"