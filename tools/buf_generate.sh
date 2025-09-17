#!/usr/bin/env bash

# Generate Go and Python proto files using Buf CLI
# This script replaces the Bazel-based generation for Go and Python

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${REPO_ROOT}"

echo "Generating Go and Python proto files using Buf..."

# Use buf generate to create Go and Python files
buf generate

echo "Proto generation complete!"
echo "Generated files:"
echo "  Go: go/"
echo "  Python: python/"