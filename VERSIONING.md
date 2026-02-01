# Versioning Guide

This document describes the versioning and release process for the xDS project.

## Overview

The xDS project maintains separate versioning for different language ecosystems:

- **Python**: Published to PyPI as the `xds` package
- **Go**: Published as Go modules at `github.com/cncf/xds/go`
- **Bazel**: Published to Bazel Central Registry (BCR) as `xds` module

## Version Format

All versions follow [Semantic Versioning 2.0.0](https://semver.org/):

- **MAJOR** version for incompatible API changes
- **MINOR** version for backwards-compatible functionality additions
- **PATCH** version for backwards-compatible bug fixes

## Tag Format

Tags are namespaced by ecosystem:

- Python releases: `python/v1.2.3`
- Go releases: `go/v1.2.3`
- Bazel releases: `bazel/v1.2.3` or `v1.2.3` (for BCR compatibility)

## Release Process

### Manual Version Bump

Use the Version Bump workflow to update version numbers:

1. Go to **Actions** → **Version Bump**
2. Click **Run workflow**
3. Select the ecosystem (python, go, or bazel)
4. Enter the new version (e.g., `1.2.3`)
5. Choose whether to create a tag immediately
6. Click **Run workflow**

This will:
- Update the version in the appropriate file
- Commit the changes
- Optionally create and push a version tag

### Automated Release

When a version tag is pushed, the appropriate release workflow automatically:

#### Python (`python/v*` tags)
1. Builds the Python package
2. Publishes to PyPI
3. Creates a GitHub release with artifacts

#### Go (`go/v*` tags)
1. Verifies the Go module
2. Runs tests
3. Creates a GitHub release

#### Bazel (`bazel/v*` or `v*` tags)
1. Builds and tests with Bazel
2. Generates language files from protos
3. Creates BCR submission files (MODULE.bazel, source.json, presubmit.yml)
4. Creates a source archive with integrity hash
5. Creates a GitHub release with BCR submission files

### Creating a Release Manually

#### Python Release

```bash
# Update version in pyproject.toml
cd python
# Edit pyproject.toml and change version = "X.Y.Z"

# Commit changes
git add pyproject.toml
git commit -m "chore(python): bump version to X.Y.Z"
git push

# Create and push tag
git tag python/vX.Y.Z
git push origin python/vX.Y.Z
```

#### Go Release

```bash
# Optionally create a VERSION file
cd go
echo "X.Y.Z" > VERSION
git add VERSION
git commit -m "chore(go): bump version to X.Y.Z"
git push

# Create and push tag
git tag go/vX.Y.Z
git push origin go/vX.Y.Z
```

#### Bazel Release

```bash
# Update version in MODULE.bazel
sed -i 's/version = ".*"/version = "X.Y.Z"/' MODULE.bazel

# Commit changes
git add MODULE.bazel
git commit -m "chore(bazel): bump version to X.Y.Z"
git push

# Create and push tag (can use either format)
git tag bazel/vX.Y.Z  # or just vX.Y.Z for BCR
git push origin bazel/vX.Y.Z

# After release is created, submit to BCR:
# 1. Download BCR submission files from GitHub release
# 2. Fork https://github.com/bazelbuild/bazel-central-registry
# 3. Create modules/xds/X.Y.Z/ directory
# 4. Copy MODULE.bazel, source.json, and presubmit.yml
# 5. Submit pull request to BCR
```

## Publishing Credentials

### Python (PyPI)

The Python release workflow uses OIDC trusted publishing. To configure:

1. Go to PyPI → Account Settings → Publishing
2. Add a new publisher:
   - PyPI Project Name: `xds`
   - Owner: `<your-github-username>` (or organization name)
   - Repository: `xds`
   - Workflow: `python-release.yml`
   - Environment: (leave empty)

No API tokens are needed with OIDC.

### Go Modules

Go modules are automatically published when tags are pushed. No additional setup required.

### Bazel (BCR)

Bazel modules require manual submission to the Bazel Central Registry after creating a release:

1. Create a release tag (triggers automatic BCR file generation)
2. Download the BCR submission files from the GitHub release
3. Fork [bazel-central-registry](https://github.com/bazelbuild/bazel-central-registry)
4. Create a new directory: `modules/xds/<version>/`
5. Copy the following files from the release to this directory:
   - `MODULE.bazel`
   - `source.json`
   - `presubmit.yml`
6. Submit a pull request to the BCR repository
7. Wait for BCR maintainers to review and merge

See [BCR documentation](https://github.com/bazelbuild/bazel-central-registry/blob/main/docs/README.md) for more details.

## Changelog

The project maintains a `CHANGELOG.md` file that is automatically updated when releases are published.

To manually update the changelog:

```bash
# Edit CHANGELOG.md following Keep a Changelog format
git add CHANGELOG.md
git commit -m "docs: update changelog for vX.Y.Z"
git push
```

## Release Drafter

The Release Drafter workflow automatically creates draft releases based on merged pull requests. Labels on PRs determine the version bump and categorization:

### Version Labels
- `major` or `breaking` → Major version bump
- `minor` or `feature` → Minor version bump  
- `patch`, `fix`, or `bugfix` → Patch version bump

### Category Labels
- `feature` or `enhancement` → 🚀 Features
- `fix`, `bugfix`, or `bug` → 🐛 Bug Fixes
- `chore` or `dependencies` → 🧰 Maintenance
- `documentation` or `docs` → 📚 Documentation

## Best Practices

1. **Always test before releasing**: Run tests locally and in CI before creating a release tag
2. **Update documentation**: Ensure README and docs reflect changes
3. **Write clear release notes**: Describe what changed and why
4. **Follow semantic versioning**: Be consistent with version number meanings
5. **Coordinate releases**: If Python, Go, and Bazel packages change together, coordinate their releases
6. **Review draft releases**: Use the automated draft releases as a starting point
7. **Test Bazel builds**: Before releasing to BCR, ensure `bazel build //...` and `bazel test //...` pass
8. **BCR submission**: For Bazel releases, don't forget to submit to BCR after creating the GitHub release
