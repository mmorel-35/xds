#!/usr/bin/env bash

set -e

# Run buf format check if buf is available
if command -v buf &> /dev/null; then
    echo "Running buf format check..."
    buf format --diff --exit-code || {
        echo "Error: Proto files are not properly formatted."
        echo "Please run 'buf format -w' to fix formatting issues."
        exit 1
    }
    echo "Buf format check passed."
fi

bazel test --config=ci //...

rm -rf go/xds go/udpa

tools/generate_lang_files_from_protos.py

git add go/xds go/udpa

echo "If this check fails, apply following diff:"
git diff HEAD
git diff HEAD --quiet
