# Developer documentation

## Synchronize generated files

Run the following command to update the generated files and commit them with your change:

```sh
bazel build //...
tools/generate_go_protobuf.py
```

## Buf tools

### Format proto files

To format all proto files in the workspace:

```sh
bazel run //:buf_format
```

To check if proto files are formatted correctly (used in CI):

```sh
bazel run //:buf_format -- -d
```

### Linting

Buf linting is automatically run as part of the test suite:

```sh
bazel test //...
```

### Breaking change detection

To enable breaking change detection for a proto package, add the `breaking_against` parameter to `xds_proto_package()` in your BUILD file:

```starlark
xds_proto_package(
    breaking_against = "//path/to:baseline_image.binpb",
)
```

To create a baseline image file from your current proto definitions:

1. Build your proto package: `bazel build //your/package:pkg`
2. Use buf to generate the image (requires buf CLI or via Bazel)

For more information, see the [Buf documentation](https://buf.build/docs/build-systems/bazel/).
