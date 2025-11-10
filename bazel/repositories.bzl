load(":envoy_http_archive.bzl", "xds_http_archive")
load(":repository_locations.bzl", "REPOSITORY_LOCATIONS")

def xds_api_dependencies():
    # Load bazel_features and bazel_skylib first as they're needed by rules_cc
    # bazel_skylib must be loaded before bazel_features_deps() is called
    xds_http_archive(
        "bazel_skylib",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        "bazel_features",
        locations = REPOSITORY_LOCATIONS,
    )

def xds_api_dependencies_extra():
    """Load additional dependencies after bazel_features_deps() is called."""
    xds_http_archive(
        "bazel_gazelle",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        "com_envoyproxy_protoc_gen_validate",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        name = "com_github_grpc_grpc",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        name = "com_google_googleapis",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        "com_google_protobuf",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        name = "dev_cel",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        "io_bazel_rules_go",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        "rules_python",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        "rules_proto",
        locations = REPOSITORY_LOCATIONS,
    )
    xds_http_archive(
        "rules_cc",
        locations = REPOSITORY_LOCATIONS,
    )

# Old name for backward compatibility.
# TODO(roth): Remove once all callers are updated to use the new name.
def udpa_api_dependencies():
    xds_api_dependencies()

def udpa_api_dependencies_extra():
    xds_api_dependencies_extra()
