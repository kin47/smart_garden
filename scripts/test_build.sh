#!/bin/bash

# Test script for local build verification
set -e

echo "🧪 Testing Flutter build process..."

# Clean previous builds
echo "📦 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📥 Getting dependencies..."
flutter pub get

# Generate code
echo "🔧 Generating code..."
dart run build_runner build --delete-conflicting-outputs

# Run tests
echo "🧪 Running tests..."
flutter test --coverage

# Build APK
echo "🏗️ Building APK..."
flutter build apk --flavor dev --release

echo "✅ Build test completed successfully!"
echo "📱 APK location: build/app/outputs/flutter-apk/app-dev-release.apk" 