REPOSITORY_LOCATIONS = dict(
    bazel_features = dict(
        sha256 = "c41853e3b636c533b86bf5ab4658064e6cc9db0a3bce52cbff0629e094344ca9",
        strip_prefix = "bazel_features-1.33.0",
        urls = ["https://github.com/bazel-contrib/bazel_features/releases/download/v1.33.0/bazel_features-v1.33.0.tar.gz"],
    ),
    bazel_gazelle = dict(
        sha256 = "675114d8b433d0a9f54d81171833be96ebc4113115664b791e6f204d58e93446",
        urls = [
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.47.0/bazel-gazelle-v0.47.0.tar.gz",
        ],
    ),
    bazel_skylib = dict(
        sha256 = "6e78f0e57de26801f6f564fa7c4a48dc8b36873e416257a92bbb0937eeac8446",
        urls = ["https://github.com/bazelbuild/bazel-skylib/releases/download/1.8.2/bazel-skylib-1.8.2.tar.gz"],
    ),
    com_envoyproxy_protoc_gen_validate = dict(
        sha256 = "26dc6db523ee943af51fdfc292658a2dbe7046735654f1dc839745988f0fe26b",
        strip_prefix = "protoc-gen-validate-1.3.0",
        urls = ["https://github.com/bufbuild/protoc-gen-validate/archive/refs/tags/v1.3.0.tar.gz"],
    ),
    com_github_grpc_grpc = dict(
        sha256 = "0af37b800953130b47c075b56683ee60bdc3eda3c37fc6004193f5b569758204",
        strip_prefix = "grpc-1.76.0",
        urls = ["https://github.com/grpc/grpc/archive/refs/tags/v1.76.0.tar.gz"],
    ),
    com_google_googleapis = dict(
        # TODO(dio): Consider writing a Starlark macro for importing Google API proto.
        sha256 = "a7fcd63679a62be91e3467596d036bf61e3e6337fd036a5886fe10edadcb8383",
        strip_prefix = "googleapis-8cd3749f4b98f2eeeef511c16431979aeb3a6502",
        urls = [
            "https://github.com/googleapis/googleapis/archive/8cd3749f4b98f2eeeef511c16431979aeb3a6502.zip",
        ],
    ),
    com_google_protobuf = dict(
        sha256 = "0c98bb704ceb4e68c92f93907951ca3c36130bc73f87264e8c0771a80362ac97",
        strip_prefix = "protobuf-33.1",
        urls = ["https://github.com/protocolbuffers/protobuf/archive/v33.1.tar.gz"],
    ),
    dev_cel = dict(
        sha256 = "13583c5a312861648449845b709722676a3c9b43396b6b8e9cbe4538feb74ad2",
        strip_prefix = "cel-spec-0.25.1",
        urls = ["https://github.com/google/cel-spec/archive/refs/tags/v0.25.1.tar.gz"],
    ),
    io_bazel_rules_go = dict(
        sha256 = "68af54cb97fbdee5e5e8fe8d210d15a518f9d62abfd71620c3eaff3b26a5ff86",
        urls = [
            "https://github.com/bazelbuild/rules_go/releases/download/v0.59.0/rules_go-v0.59.0.zip",
        ],
    ),
    rules_cc = dict(
        sha256 = "a2fdfde2ab9b2176bd6a33afca14458039023edb1dd2e73e6823810809df4027",
        strip_prefix = "rules_cc-0.2.14",
        urls = ["https://github.com/bazelbuild/rules_cc/archive/refs/tags/0.2.14.tar.gz"],
    ),
    rules_proto = dict(
        sha256 = "14a225870ab4e91869652cfd69ef2028277fc1dc4910d65d353b62d6e0ae21f4",
        strip_prefix = "rules_proto-7.1.0",
        urls = ["https://github.com/bazelbuild/rules_proto/archive/refs/tags/7.1.0.tar.gz"],
    ),
    rules_python = dict(
        sha256 = "f609f341d6e9090b981b3f45324d05a819fd7a5a56434f849c761971ce2c47da",
        strip_prefix = "rules_python-1.7.0",
        urls = ["https://github.com/bazelbuild/rules_python/archive/1.7.0.tar.gz"],
    ),
)
