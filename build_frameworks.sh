#!/bin/bash

echo "🔧 Building Flutter frameworks for ClevercardsFlutterWrapper..."

# Navigate to Flutter module
cd ../clevercard-module

echo "📱 Building Release frameworks..."
flutter build ios-framework --release --output=../ios-wrapper-module/

# Navigate back to wrapper
cd ../ios-wrapper-module

echo "🧹 Cleaning up _CodeSignature directories..."
find Debug Profile Release -name "_CodeSignature" -type d -exec rm -rf {} + 2>/dev/null || true

echo "✅ Framework build complete!"
echo ""
echo "📋 Next steps:"
echo "1. Update podspec version if needed"
echo "2. Test with a demo app"
echo "3. Publish to CocoaPods" 