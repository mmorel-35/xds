#!/usr/bin/env bash

set -e

bazel test --config=ci //...

# Remove old generated files
rm -rf go/xds go/udpa python/xds python/udpa

# Generate using Buf v2 configuration
buf generate

git add go/xds go/udpa python/xds python/udpa

echo "If this check fails, apply following diff:"
git diff HEAD
git diff HEAD --quiet
