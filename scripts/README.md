# Deployment Scripts

This directory contains scripts for building and deploying the Smart Garden Flutter application.

## Scripts Overview

### 1. `test_build.sh` - Local Build Testing
Tests the complete build process locally before pushing to CI.

**Usage:**
```bash
./scripts/test_build.sh
```

**What it does:**
- Cleans previous builds
- Installs dependencies
- Generates code with build_runner
- Runs tests with coverage
- Builds APK with dev flavor

### 2. `deploy_firebase.sh` - Firebase App Distribution
Deploys the APK to Firebase App Distribution for testing.

**Usage:**
```bash
# Deploy with default settings (dev flavor, testers group)
./scripts/deploy_firebase.sh

# Deploy with custom flavor
./scripts/deploy_firebase.sh -f dev -t release

# Deploy to specific tester groups
./scripts/deploy_firebase.sh -g "qa,beta,internal"

# Show help
./scripts/deploy_firebase.sh -h

# Show version info
./scripts/deploy_firebase.sh -v
```

**Options:**
- `-f, --flavor`: Build flavor (default: dev)
- `-t, --type`: Build type (default: release)
- `-g, --groups`: Tester groups (default: testers)
- `-n, --notes`: Custom release notes file
- `-h, --help`: Show help message
- `-v, --version`: Show version information

## Prerequisites

### For Local Deployment

1. **Install Firebase CLI:**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase:**
   ```bash
   firebase login
   ```

3. **Verify Firebase CLI:**
   ```bash
   firebase projects:list
   ```

### For GitHub Actions Deployment

1. **Set up Firebase Service Account:**
   - Go to Firebase Console → Project Settings → Service Accounts
   - Generate new private key
   - Add the JSON content as a GitHub secret named `FIREBASE_SERVICE_ACCOUNT`

2. **Configure Tester Groups:**
   - Go to Firebase Console → App Distribution → Testers & Groups
   - Create tester groups (e.g., "testers", "qa", "beta")

## Firebase Configuration

### Project Details
- **Project ID:** `smart-garden-cd3b0`
- **Android App ID:** `1:702709402883:android:6ea2d9e5faaabb704d2d36`
- **Package Name:** `com.example.smart_garden`

### Build Flavors
- **dev:** Development build for testing
- **staging:** Staging build for QA
- **production:** Production build (when ready)

## Deployment Workflows

### Manual Deployment
```bash
# Build and deploy to Firebase App Distribution
./scripts/deploy_firebase.sh

# Deploy to specific groups
./scripts/deploy_firebase.sh -g "qa,beta"
```

### Automated Deployment (GitHub Actions)
The deployment is automatically triggered on:
- Push to `develop` branch
- Push of version tags (e.g., `v1.0.0`)
- Manual workflow dispatch

### Manual Workflow Trigger
1. Go to GitHub Actions tab
2. Select "Firebase App Distribution" workflow
3. Click "Run workflow"
4. Choose flavor and tester groups
5. Click "Run workflow"

## Release Notes

The deployment script automatically generates release notes including:
- App version from `pubspec.yaml`
- Build information (Flutter version, flavor, type)
- Git commit hash and branch
- Installation instructions
- Technical details

## Troubleshooting

### Common Issues

1. **Firebase CLI not found:**
   ```bash
   npm install -g firebase-tools
   firebase login
   ```

2. **Not logged in to Firebase:**
   ```bash
   firebase login
   ```

3. **APK not found:**
   - Run `./scripts/test_build.sh` first
   - Check if the correct flavor is specified

4. **Permission denied:**
   ```bash
   chmod +x scripts/*.sh
   ```

5. **GitHub Actions fails:**
   - Check if `FIREBASE_SERVICE_ACCOUNT` secret is set
   - Verify Firebase project ID and app ID
   - Check tester groups exist in Firebase Console

### Debug Mode
Run scripts with verbose output:
```bash
bash -x ./scripts/deploy_firebase.sh
```

## Best Practices

1. **Always test locally first:**
   ```bash
   ./scripts/test_build.sh
   ```

2. **Use meaningful version numbers:**
   Update `pubspec.yaml` version before deployment

3. **Test with small groups first:**
   Deploy to internal testers before wider distribution

4. **Monitor deployment:**
   Check Firebase Console for distribution status

5. **Keep release notes updated:**
   Customize the release notes template for your needs

## Integration with CI/CD

The deployment scripts are integrated with:
- **GitHub Actions:** Automated deployment on push/tags
- **Firebase App Distribution:** For testing and feedback
- **Artifact Storage:** APK files stored for download

## Support

For issues with deployment:
1. Check the troubleshooting section above
2. Review Firebase Console logs
3. Check GitHub Actions logs
4. Verify Firebase project configuration 