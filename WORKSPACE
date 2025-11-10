workspace(name = "com_github_cncf_xds")

# Phase 1: Load bazel_features first
load("//bazel:repositories.bzl", "udpa_api_dependencies")

udpa_api_dependencies()

# Phase 2: Initialize bazel_features dependencies
load("@bazel_features//:deps.bzl", "bazel_features_deps")

bazel_features_deps()

# Phase 3: Load remaining repositories
load("//bazel:repositories.bzl", "udpa_api_dependencies_extra")

udpa_api_dependencies_extra()

# Phase 4: Load dependency imports
load("//bazel:dependency_imports.bzl", "udpa_dependency_imports")

udpa_dependency_imports()
