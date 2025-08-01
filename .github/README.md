# CI/CD Workflows

This directory contains GitHub Actions workflows for the Smart Garden Flutter application.

## Workflows

### 1. CI (`ci.yml`)
Runs on every push to `develop`/`main` branches and pull requests.

**Jobs:**
- **Analyze**: Code analysis and formatting checks
- **Test**: Unit tests with coverage reporting
- **Build Android**: APK build for Android
- **Build iOS**: iOS build (without code signing)

**Features:**
- Dependency caching for faster builds
- Code coverage upload to Codecov
- Artifact storage for builds
- Security vulnerability scanning

### 2. Release (`release.yml`)
Runs when a tag starting with `v` is pushed (e.g., `v1.0.0`).

**Jobs:**
- **Build Android Release**: Creates APK and App Bundle
- **Build iOS Release**: Creates iOS build
- **Create Release**: Automatically creates GitHub release with artifacts

### 3. CodeQL (`codeql.yml`)
Advanced security analysis using GitHub's CodeQL.

**Features:**
- Static analysis for security vulnerabilities
- Runs on schedule (weekly) and on code changes
- Integrates with GitHub Security tab

## Configuration

### Environment Variables
- `FLUTTER_VERSION`: '3.22.3'
- `JAVA_VERSION`: '17'

### Dependencies
The workflows use the following key dependencies:
- Flutter 3.22.3
- Java 17 (Temurin distribution)
- Various GitHub Actions (see individual workflow files)

## Setup Requirements

### Repository Secrets
For full functionality, consider setting up these secrets:
- `CODECOV_TOKEN`: For code coverage reporting
- `FIREBASE_SERVICE_ACCOUNT`: For Firebase deployments (if needed)

### Branch Protection
Recommended branch protection rules:
- Require status checks to pass before merging
- Require branches to be up to date before merging
- Require pull request reviews

## Usage

### Running Tests Locally
```bash
# Install dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Run tests
flutter test --coverage

# Analyze code
flutter analyze

# Check formatting
dart format --set-exit-if-changed .
```

### Creating a Release
```bash
# Create and push a tag
git tag v1.0.0
git push origin v1.0.0
```

This will automatically trigger the release workflow and create a GitHub release with the built artifacts.

## Monitoring

### Build Status
- Check the "Actions" tab in GitHub for workflow status
- Monitor build times and failure rates
- Review security scan results in the Security tab

### Coverage Reports
- Code coverage is uploaded to Codecov
- View detailed coverage reports and trends
- Set up coverage thresholds if needed

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Check Flutter version compatibility
   - Verify all dependencies are properly declared
   - Review generated code conflicts

2. **Test Failures**
   - Ensure all tests are properly written
   - Check for environment-specific issues
   - Verify mock configurations

3. **Security Scan Issues**
   - Review Trivy and CodeQL results
   - Update dependencies with known vulnerabilities
   - Address false positives if necessary

### Performance Optimization
- Monitor build times and optimize slow steps
- Consider using self-hosted runners for faster builds
- Optimize dependency caching strategies 