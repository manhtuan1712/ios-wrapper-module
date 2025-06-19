# ClevercardsFlutterWrapper

iOS wrapper for easy integration of Clevercards Flutter module into native iOS applications.

## 🚀 Installation

### Step 1: Add to Podfile

Add both the wrapper and direct Flutter integration to your Podfile:

```ruby
platform :ios, '13.0'

# Path to your Flutter module (adjust path as needed)
flutter_module_path = '../clevercard-module'

# Load Flutter module podhelper
load File.join(flutter_module_path, '.ios', 'Flutter', 'podhelper.rb')

target 'YourApp' do
  use_frameworks!
  
  # Install Flutter pods (REQUIRED)
  install_all_flutter_pods(flutter_module_path)
  
  # Add the wrapper
  pod 'ClevercardsFlutterWrapper'
end

# Post-install hook for Flutter compatibility
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
  
  flutter_post_install(installer) if defined?(flutter_post_install)
end
```

### Step 2: Run Pod Install

```bash
pod install
```

## 📱 Usage

### Import the Framework

```swift
import ClevercardsFlutterWrapper
```

### Open Flutter Module

```swift
class ViewController: UIViewController {
    
    @IBAction func openFlutterModule(_ sender: Any) {
        FlutterModuleWrapper.shared.openFlutterModule(
            from: self,
            message: "Hello from native iOS!"
        )
    }
}
```

### Use Card Services

```swift
class CardViewController: UIViewController {
    
    func getCardDetails() async {
        do {
            let cardDetail = try await FlutterModuleWrapper.shared.getCardDetail(giftCode: "ABC123")
            print("Card Name: \(cardDetail.name ?? "Unknown")")
            print("Balance: \(cardDetail.remainingBalance ?? 0)")
        } catch {
            print("Error getting card details: \(error)")
        }
    }
    
    func getTokens() async {
        do {
            let token = try await FlutterModuleWrapper.shared.getCardTokens()
            print("Token: \(token)")
        } catch {
            print("Error getting tokens: \(error)")
        }
    }
    
    func decryptPiece() async {
        do {
            let decrypted = try await FlutterModuleWrapper.shared.decryptCardPiece(
                encryptedPiece: "encrypted_data_here"
            )
            print("Decrypted: \(decrypted)")
        } catch {
            print("Error decrypting: \(error)")
        }
    }
}
```

## 🏗 Architecture

This wrapper works in conjunction with direct Flutter integration:

- **Direct Flutter Integration**: Handles the Flutter engine, runtime, and asset loading
- **ClevercardsFlutterWrapper**: Provides a clean Swift API for native developers

### Why This Architecture?

1. **Reliability**: Direct Flutter integration ensures proper asset loading and engine management
2. **Compatibility**: Works with all Flutter versions and doesn't fight with Xcode's sandbox
3. **Maintainability**: No need to rebuild frameworks for every Flutter update
4. **Performance**: Single Flutter engine instance, no conflicts

## 🔧 Requirements

- iOS 13.0+
- Xcode 12.0+
- Flutter module with method channels configured for:
  - `clevercards/message`
  - `clevercard_module/card_service`

## 📋 Flutter Module Setup

Your Flutter module should have these method channels configured:

```dart
// For message passing
static const platform = MethodChannel('clevercards/message');

// For card services  
static const cardService = MethodChannel('clevercard_module/card_service');
```

## 🐛 Troubleshooting

### Common Issues

1. **Blank Screen**: Ensure you have both `install_all_flutter_pods()` AND the wrapper pod installed
2. **Method Channel Errors**: Verify your Flutter module has the required method channels
3. **Build Errors**: Make sure your Flutter module path is correct in the Podfile

### Debug Steps

1. Check that Flutter frameworks are properly linked in your Xcode project
2. Verify the Flutter module builds successfully with `flutter build ios`
3. Ensure your iOS deployment target is 13.0 or higher

## 📚 API Reference

### FlutterModuleWrapper

- `openFlutterModule(from:message:)` - Opens the Flutter module UI
- `getCardDetail(giftCode:)` - Retrieves card details 
- `getCardTokens()` - Gets card tokens
- `decryptCardPiece(encryptedPiece:)` - Decrypts card data

### CardDetail

Public properties:
- `cardId`, `giftCode`, `name`, `currency`
- `originalBalance`, `remainingBalance`
- `expiryDate`, `formattedPan`, `maskedPan`
- `encryptedCvv`, `encryptedPan`

## 🔄 Migration from Previous Versions

If you were using vendored frameworks before:

1. Remove any manually added Flutter frameworks from "Link Binary With Libraries"
2. Update your Podfile to use direct integration as shown above
3. Clean build folder and run `pod install`

## 📄 License

MIT License 