#!/bin/bash

# Firebase App Distribution Setup Script
# This script helps set up Firebase App Distribution for the Smart Garden app

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

setup_firebase_cli() {
    print_status "Setting up Firebase CLI..."
    
    if ! command_exists npm; then
        print_error "npm is not installed. Please install Node.js first:"
        echo "https://nodejs.org/"
        exit 1
    fi
    
    if ! command_exists firebase; then
        print_status "Installing Firebase CLI..."
        npm install -g firebase-tools
        print_success "Firebase CLI installed successfully!"
    else
        print_success "Firebase CLI is already installed!"
    fi
    
    # Check if user is logged in
    if ! firebase projects:list >/dev/null 2>&1; then
        print_status "Please log in to Firebase..."
        firebase login
    else
        print_success "Already logged in to Firebase!"
    fi
}

setup_tester_groups() {
    print_status "Setting up tester groups..."
    
    echo "Creating tester groups in Firebase Console..."
    echo ""
    echo "Please follow these steps:"
    echo "1. Go to https://console.firebase.google.com/project/smart-garden-cd3b0"
    echo "2. Navigate to App Distribution → Testers & Groups"
    echo "3. Create the following groups:"
    echo "   - testers (default group)"
    echo "   - qa (quality assurance)"
    echo "   - beta (beta testers)"
    echo "   - internal (internal team)"
    echo ""
    echo "4. Add testers to these groups"
    echo ""
    
    read -p "Press Enter when you've completed setting up tester groups..."
}

setup_github_secrets() {
    print_status "Setting up GitHub secrets..."
    
    echo "To enable automated deployment, you need to set up GitHub secrets:"
    echo ""
    echo "1. Go to your GitHub repository"
    echo "2. Navigate to Settings → Secrets and variables → Actions"
    echo "3. Add the following secret:"
    echo ""
    echo "   Name: FIREBASE_SERVICE_ACCOUNT"
    echo "   Value: [Firebase service account JSON]"
    echo ""
    echo "To get the service account JSON:"
    echo "1. Go to Firebase Console → Project Settings → Service Accounts"
    echo "2. Click 'Generate new private key'"
    echo "3. Copy the entire JSON content"
    echo "4. Paste it as the secret value"
    echo ""
    
    read -p "Press Enter when you've set up the GitHub secret..."
}

test_deployment() {
    print_status "Testing deployment setup..."
    
    if [ -f "build/app/outputs/flutter-apk/app-dev-release.apk" ]; then
        print_status "APK found, testing deployment..."
        ./scripts/deploy_firebase.sh -g "testers" || {
            print_error "Deployment test failed. Please check the error messages above."
            return 1
        }
        print_success "Deployment test successful!"
    else
        print_warning "No APK found. Building first..."
        ./scripts/test_build.sh
        print_status "Now testing deployment..."
        ./scripts/deploy_firebase.sh -g "testers" || {
            print_error "Deployment test failed. Please check the error messages above."
            return 1
        }
        print_success "Deployment test successful!"
    fi
}

show_next_steps() {
    print_success "🎉 Firebase App Distribution setup completed!"
    echo ""
    echo "Next steps:"
    echo "1. Test the deployment: ./scripts/deploy_firebase.sh"
    echo "2. Push to develop branch to trigger automated deployment"
    echo "3. Check Firebase Console for distribution status"
    echo "4. Add testers to your groups"
    echo ""
    echo "Useful commands:"
    echo "  ./scripts/deploy_firebase.sh -h          # Show help"
    echo "  ./scripts/deploy_firebase.sh -v          # Show version"
    echo "  ./scripts/deploy_firebase.sh -g \"qa\"    # Deploy to QA group"
    echo ""
}

main() {
    echo "🚀 Firebase App Distribution Setup for Smart Garden"
    echo "=================================================="
    echo ""
    
    # Setup Firebase CLI
    setup_firebase_cli
    
    # Setup tester groups
    setup_tester_groups
    
    # Setup GitHub secrets
    setup_github_secrets
    
    # Test deployment
    if test_deployment; then
        show_next_steps
    else
        print_error "Setup completed with errors. Please review the issues above."
        exit 1
    fi
}

# Run main function
main "$@" 