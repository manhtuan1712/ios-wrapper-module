# ClevercardsFlutterWrapper

iOS wrapper for easy integration of Clevercards Flutter module into native iOS applications.

## 🚀 Installation

### Step 1: Add to Podfile

Add the wrapper to your Podfile with appropriate subspecs:

```ruby
platform :ios, '13.0'

target 'YourApp' do
  use_frameworks!
  
  # Match Flutter build configurations
  pod 'ClevercardsFlutterWrapper/Debug', :configurations => ['Debug']
  pod 'ClevercardsFlutterWrapper/Profile', :configurations => ['Profile']  
  pod 'ClevercardsFlutterWrapper/Release', :configurations => ['Release']
end

# Post-install hook for compatibility
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
```

#### Alternative: Single Subspec (Simpler)

If you only need specific build configurations:

```ruby
# For debug builds (simulator)
pod 'ClevercardsFlutterWrapper/Debug'

# For profile builds (optimized simulator/device)
pod 'ClevercardsFlutterWrapper/Profile'

# For release builds (device)
pod 'ClevercardsFlutterWrapper/Release'

# For default (defaults to Release)
pod 'ClevercardsFlutterWrapper'
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

This wrapper provides a complete solution with pre-built Flutter frameworks:

- **Pre-built Frameworks**: Includes Flutter engine and all required plugins for each build configuration
- **Swift Wrapper API**: Clean Swift classes (`FlutterModuleWrapper`, `CardDetail`, `CardService`) included in all subspecs
- **Configuration-Specific**: Debug/Profile/Release subspecs with appropriate frameworks

### Why This Architecture?

1. **Simplicity**: Single pod installation, no complex Flutter setup required
2. **Reliability**: Pre-tested framework combinations
3. **Compatibility**: Works without requiring Flutter SDK on developer machines
4. **Performance**: Optimized frameworks for each platform

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

1. **Blank Screen on Simulator**: Ensure you're using the Debug subspec for simulator builds
2. **Missing kernel_blob.bin**: Use `ClevercardsFlutterWrapper/Debug` for simulator
3. **Method Channel Errors**: Verify your Flutter module has the required method channels  
4. **Build Errors**: Clean build folder and reinstall pods if switching subspecs

### Debug Steps

1. Check which subspec you're using matches your build configuration
2. For simulator issues, use: `pod 'ClevercardsFlutterWrapper/Debug'`
3. For optimized builds, use: `pod 'ClevercardsFlutterWrapper/Profile'`
4. For device/production, use: `pod 'ClevercardsFlutterWrapper/Release'`
5. Ensure your iOS deployment target is 13.0 or higher

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