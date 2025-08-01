#!/bin/bash

# Firebase App Distribution Deployment Script
# This script builds and deploys the APK to Firebase App Distribution

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ID="smart-garden-cd3b0"
APP_ID="1:702709402883:android:6ea2d9e5faaabb704d2d36"
FLAVOR="dev"
BUILD_TYPE="release"
APK_PATH="build/app/outputs/flutter-apk/app-${FLAVOR}-${BUILD_TYPE}.apk"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check Firebase CLI
check_firebase_cli() {
    if ! command_exists firebase; then
        print_error "Firebase CLI is not installed. Please install it first:"
        echo "npm install -g firebase-tools"
        echo "firebase login"
        exit 1
    fi
    
    # Check if user is logged in
    if ! firebase projects:list >/dev/null 2>&1; then
        print_error "You are not logged in to Firebase. Please run:"
        echo "firebase login"
        exit 1
    fi
}

# Function to get version from pubspec.yaml
get_version() {
    local version=$(grep '^version:' pubspec.yaml | sed 's/version: //' | tr -d ' ')
    echo "$version"
}

# Function to generate release notes
generate_release_notes() {
    local version=$(get_version)
    local date=$(date '+%Y-%m-%d %H:%M:%S')
    local commit_hash=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
    
    cat << EOF
🚀 Smart Garden App v${version}

📅 Released: ${date}
🔗 Commit: ${commit_hash}

📱 What's New:
• Bug fixes and performance improvements
• Enhanced user experience
• Updated dependencies

🔧 Technical Details:
• Flutter version: $(flutter --version | grep -o 'Flutter [0-9.]*' | head -1)
• Build flavor: ${FLAVOR}
• Build type: ${BUILD_TYPE}

📋 Installation:
1. Download the APK from the link below
2. Enable "Install from unknown sources" in your device settings
3. Install the APK file

⚠️ Note: This is a development build for testing purposes.
EOF
}

# Main deployment function
deploy_to_firebase() {
    local version=$(get_version)
    local release_notes_file="/tmp/release_notes_${version}.txt"
    
    print_status "Starting Firebase App Distribution deployment..."
    print_status "Project ID: ${PROJECT_ID}"
    print_status "App ID: ${APP_ID}"
    print_status "Version: ${version}"
    print_status "APK Path: ${APK_PATH}"
    
    # Check if APK exists
    if [ ! -f "$APK_PATH" ]; then
        print_error "APK file not found at: $APK_PATH"
        print_status "Building APK first..."
        flutter build apk --flavor $FLAVOR --$BUILD_TYPE
    fi
    
    # Generate release notes
    print_status "Generating release notes..."
    generate_release_notes > "$release_notes_file"
    
    # Deploy to Firebase App Distribution
    print_status "Deploying to Firebase App Distribution..."
    
    firebase appdistribution:distribute "$APK_PATH" \
        --app "$APP_ID" \
        --release-notes-file "$release_notes_file" \
        --groups "testers" \
        --project "$PROJECT_ID"
    
    if [ $? -eq 0 ]; then
        print_success "✅ Successfully deployed to Firebase App Distribution!"
        print_success "📱 Version: ${version}"
        print_success "🔗 Check your Firebase Console for the distribution link"
        
        # Clean up
        rm -f "$release_notes_file"
        
        # Show recent distributions
        print_status "Recent distributions:"
        firebase appdistribution:releases:list --app "$APP_ID" --project "$PROJECT_ID" --limit 3
    else
        print_error "❌ Failed to deploy to Firebase App Distribution"
        rm -f "$release_notes_file"
        exit 1
    fi
}

# Function to show help
show_help() {
    echo "Firebase App Distribution Deployment Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help          Show this help message"
    echo "  -v, --version       Show version information"
    echo "  -f, --flavor        Build flavor (default: dev)"
    echo "  -t, --type          Build type (default: release)"
    echo "  -g, --groups        Tester groups (default: testers)"
    echo "  -n, --notes         Custom release notes file"
    echo ""
    echo "Examples:"
    echo "  $0                    # Deploy with default settings"
    echo "  $0 -f dev -t release  # Deploy dev flavor release build"
    echo "  $0 -g \"qa,beta\"      # Deploy to specific tester groups"
    echo ""
}

# Function to show version
show_version() {
    local version=$(get_version)
    echo "Smart Garden App v${version}"
    echo "Firebase Project: ${PROJECT_ID}"
    echo "App ID: ${APP_ID}"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--version)
            show_version
            exit 0
            ;;
        -f|--flavor)
            FLAVOR="$2"
            shift 2
            ;;
        -t|--type)
            BUILD_TYPE="$2"
            shift 2
            ;;
        -g|--groups)
            TESTER_GROUPS="$2"
            shift 2
            ;;
        -n|--notes)
            RELEASE_NOTES_FILE="$2"
            shift 2
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Update APK path based on flavor and build type
APK_PATH="build/app/outputs/flutter-apk/app-${FLAVOR}-${BUILD_TYPE}.apk"

# Main execution
main() {
    print_status "🚀 Smart Garden Firebase App Distribution Deployment"
    echo ""
    
    # Check prerequisites
    print_status "Checking prerequisites..."
    check_firebase_cli
    
    # Check if we're in a git repository
    if [ ! -d ".git" ]; then
        print_warning "Not in a git repository. Some features may be limited."
    fi
    
    # Check Flutter
    if ! command_exists flutter; then
        print_error "Flutter is not installed or not in PATH"
        exit 1
    fi
    
    # Deploy
    deploy_to_firebase
    
    print_success "🎉 Deployment completed successfully!"
}

# Run main function
main "$@" 