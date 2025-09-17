#!/usr/bin/env bash

set -e

# Check if Buf is installed
if ! command -v buf &> /dev/null; then
    echo "Error: Buf CLI is not installed. Please install Buf:"
    echo "https://docs.buf.build/installation"
    exit 1
fi

echo "Using Buf version: $(buf --version)"

bazel test --config=ci //...

# Remove old generated files
rm -rf go/xds go/udpa python/xds python/udpa

# Generate using Buf v2 configuration
echo "Generating protobuf files with Buf..."
buf generate

# Check if generated files are up to date
git add go/xds go/udpa python/xds python/udpa

echo "Checking if generated files are up to date..."
if ! git diff HEAD --quiet; then
    echo "Error: Generated files are out of date. Please run 'buf generate' and commit the changes."
    echo "The following diff shows what needs to be updated:"
    git diff HEAD
    exit 1
fi

echo "All generated files are up to date!"
