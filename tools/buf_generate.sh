#!/usr/bin/env bash

# Generate Go and Python proto files using Buf CLI
# This script replaces the Bazel-based generation for Go and Python
# Updated to use github.com/cncf/xds import paths for upstream compatibility

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${REPO_ROOT}"

echo "Generating Go and Python proto files using Buf..."
echo "Using module: github.com/cncf/xds"

# Create go.mod if it doesn't exist or update it
if [[ ! -f go/go.mod ]]; then
    echo "Creating go/go.mod with correct module path..."
    mkdir -p go
    cat > go/go.mod << EOF
module github.com/cncf/xds/go

go 1.22

require (
    github.com/bufbuild/protovalidate-go v1.0.0
    google.golang.org/protobuf v1.36.6
)
EOF
fi

# Check if buf is available
if ! command -v buf &> /dev/null; then
    echo "Warning: buf command not found. Please install buf:"
    echo "  brew install bufbuild/buf/buf  # macOS"
    echo "  or download from https://github.com/bufbuild/buf/releases"
    echo ""
    echo "For now, using the configuration files to document the intended generation..."
    echo "Generated files should be placed in:"
    echo "  Go: go/"
    echo "  Python: python/"
    exit 0
fi

# Use buf generate to create Go and Python files
buf generate

echo "Proto generation complete!"
echo "Generated files:"
echo "  Go: go/"
echo "  Python: python/"
echo "Import paths use: github.com/cncf/xds"