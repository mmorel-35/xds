# Versioning Guide

This document describes the versioning and release process for the xDS project.

## Overview

The xDS project maintains separate versioning for different language ecosystems:

- **Python**: Published to PyPI as the `xds` package
- **Go**: Published as Go modules at `github.com/cncf/xds/go`

## Version Format

All versions follow [Semantic Versioning 2.0.0](https://semver.org/):

- **MAJOR** version for incompatible API changes
- **MINOR** version for backwards-compatible functionality additions
- **PATCH** version for backwards-compatible bug fixes

## Tag Format

Tags are namespaced by ecosystem:

- Python releases: `python/v1.2.3`
- Go releases: `go/v1.2.3`

## Release Process

### Manual Version Bump

Use the Version Bump workflow to update version numbers:

1. Go to **Actions** → **Version Bump**
2. Click **Run workflow**
3. Select the ecosystem (python or go)
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

## Publishing Credentials

### Python (PyPI)

The Python release workflow uses OIDC trusted publishing. To configure:

1. Go to PyPI → Account Settings → Publishing
2. Add a new publisher:
   - PyPI Project Name: `xds`
   - Owner: `mmorel-35` (or organization)
   - Repository: `xds`
   - Workflow: `python-release.yml`
   - Environment: (leave empty)

No API tokens are needed with OIDC.

### Go Modules

Go modules are automatically published when tags are pushed. No additional setup required.

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
5. **Coordinate releases**: If both Python and Go packages change together, coordinate their releases
6. **Review draft releases**: Use the automated draft releases as a starting point
