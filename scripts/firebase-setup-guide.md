# Firebase App Distribution Setup Guide

This guide will help you set up Firebase App Distribution for your Smart Garden app.

## 🔧 Prerequisites

1. **Firebase Project**: You already have a Firebase project (`smart-garden-cd3b0`)
2. **GitHub Repository**: Your code is in a GitHub repository
3. **Firebase CLI**: For local testing

## 📋 Step-by-Step Setup

### 1. Enable Firebase App Distribution

1. Go to [Firebase Console](https://console.firebase.google.com/project/smart-garden-cd3b0)
2. Navigate to **App Distribution** in the left sidebar
3. Click **Get started** if not already enabled
4. Add your Android app if not already added

### 2. Create Firebase Service Account

1. In Firebase Console, go to **Project Settings** (gear icon)
2. Click the **Service accounts** tab
3. Click **Generate new private key**
4. Save the JSON file securely
5. **Important**: This JSON contains sensitive credentials - keep it secure!

### 3. Set Up GitHub Secrets

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `FIREBASE_SERVICE_ACCOUNT`
5. Value: Copy the **entire content** of the JSON file from step 2
6. Click **Add secret**

### 4. Create Tester Groups

1. In Firebase Console, go to **App Distribution** → **Testers & Groups**
2. Create the following groups:
   - `testers` (default group)
   - `qa` (quality assurance)
   - `beta` (beta testers)
   - `internal` (internal team)

### 5. Add Testers

1. In **Testers & Groups**, click **Add testers**
2. Add email addresses of your testers
3. Assign them to appropriate groups

## 🚀 Testing the Setup

### Local Testing

1. **Install Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:
   ```bash
   firebase login
   ```

3. **Test deployment**:
   ```bash
   ./scripts/deploy_firebase.sh
   ```

### GitHub Actions Testing

1. **Push to develop branch** to trigger automatic deployment
2. **Or manually trigger** the workflow:
   - Go to **Actions** tab in GitHub
   - Select **Firebase App Distribution**
   - Click **Run workflow**
   - Choose flavor and groups
   - Click **Run workflow**

## 🔍 Troubleshooting

### Common Issues

#### 1. "Firebase CLI not found" in GitHub Actions
**Solution**: The workflow now properly installs Firebase CLI. Make sure you're using the updated workflow file.

#### 2. "Authentication failed" or "Permission denied"
**Solution**: 
- Verify the service account JSON is correctly copied to GitHub secrets
- Ensure the service account has the necessary permissions
- Check that the project ID matches your Firebase project

#### 3. "App not found" error
**Solution**:
- Verify the app ID in the workflow matches your Firebase app
- Ensure the app is registered in Firebase App Distribution

#### 4. "Tester groups not found"
**Solution**:
- Create the tester groups in Firebase Console first
- Use exact group names (case-sensitive)

### Debug Steps

1. **Check GitHub Actions logs**:
   - Go to Actions tab
   - Click on the failed workflow
   - Check the "Setup Firebase CLI" step logs

2. **Verify service account**:
   ```bash
   # Test locally with service account
   echo 'YOUR_SERVICE_ACCOUNT_JSON' > /tmp/test.json
   export GOOGLE_APPLICATION_CREDENTIALS="/tmp/test.json"
   firebase projects:list
   ```

3. **Test Firebase CLI locally**:
   ```bash
   firebase login
   firebase projects:list
   firebase appdistribution:releases:list --app "1:702709402883:android:6ea2d9e5faaabb704d2d36"
   ```

## 📱 Service Account Permissions

Your service account needs these permissions:
- **Firebase App Distribution Admin**
- **Firebase Hosting Admin** (if using hosting)
- **Service Account Token Creator**

## 🔐 Security Best Practices

1. **Never commit service account JSON** to your repository
2. **Use GitHub secrets** for sensitive data
3. **Rotate service account keys** regularly
4. **Limit service account permissions** to minimum required
5. **Monitor usage** in Firebase Console

## 📊 Monitoring

### Firebase Console
- **App Distribution** → **Releases**: View all distributed builds
- **Testers & Groups**: Manage testers and groups
- **Analytics**: Track installation and usage

### GitHub Actions
- **Actions** tab: Monitor deployment status
- **Artifacts**: Download APK files
- **Logs**: Debug issues

## 🎯 Next Steps

1. **Test the deployment** with a small group
2. **Add more testers** as needed
3. **Set up automated releases** for different branches
4. **Configure notifications** for new releases
5. **Monitor feedback** from testers

## 📞 Support

If you encounter issues:

1. Check this troubleshooting guide
2. Review Firebase Console logs
3. Check GitHub Actions logs
4. Verify all configuration steps
5. Test locally first

## 🔄 Workflow Files

You have two workflow options:

1. **`firebase-distribution.yml`**: Main workflow with proper authentication
2. **`firebase-distribution-simple.yml`**: Alternative approach

Both should work, but the main one is recommended for production use. 