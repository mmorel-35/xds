workspace(name = "com_github_cncf_xds")

load("//:MODULE.bazel", "go_deps")
load("//bazel:repositories.bzl", "udpa_api_dependencies")

# gazelle:repository_macro MODULE.bazel%go_deps
go_deps()

udpa_api_dependencies()

load("//bazel:dependency_imports.bzl", "udpa_dependency_imports")

udpa_dependency_imports()
