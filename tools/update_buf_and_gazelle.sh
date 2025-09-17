#!/bin/bash

# Script to update buf-generated protobuf files and run Gazelle to update BUILD files
# This integrates buf generation with the Bazel build system

set -e

# Add /tmp to PATH if buf is installed there
export PATH="/tmp:$PATH"

echo "🔄 Updating protobuf files using buf and Gazelle integration..."

# Step 1: Generate protobuf files using buf
echo "📦 Generating protobuf files with buf..."
tools/generate_protobuf.sh

# Step 2: Run Gazelle to update BUILD files for generated Go files
echo "🏗️ Updating BUILD files with Gazelle..."
bazel run //:gazelle

# Step 3: Update Go module dependencies if needed
echo "📋 Updating Go module dependencies..."
bazel run //:gazelle -- update-repos -from_file=go/go.mod -to_macro=bazel/dependency_imports.bzl%xds_dependency_imports

echo "✅ Buf generation and Gazelle update completed successfully!"
echo ""
echo "Generated files:"
echo "  Go:     $(find go -name "*.go" | wc -l) files in go/ (includes XDS and UDPA)"
echo "  Python: $(find python -name "*.py" | wc -l) files in python/ (includes XDS and UDPA)"
echo ""
echo "Updated BUILD files with Gazelle for buf-generated Go files."
echo "Bazel can now build using: bazel build //go/..."