# Developer documentation

## Synchronize generated files

Run the following command to update the generated files and commit them with your change:

```sh
bazel build //...
buf generate
```

## Proto validation migration

This repository has been migrated from protoc-gen-validate (PGV) to protovalidate for modern validation. All proto files now use `buf/validate/validate.proto` imports and `(buf.validate.field)` syntax.

## Code generation

Go and Python protobuf files are generated using Buf v2 configuration with remote plugins. The generation is managed by `buf.gen.yaml` v2 format with managed mode enabled for consistent import paths.
