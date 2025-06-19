Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.3.0'
  s.summary          = 'iOS wrapper for Clevercards Flutter module'
  s.homepage         = 'https://github.com/manhtuan1712/flutter-module'
  s.license          = { :type => 'MIT' }
  s.author           = { 'You' => 'manhtuan17121994@gmail.com' }
  s.source           = { :git => 'https://github.com/manhtuan1712/flutter-module.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'SUPPORTS_MACCATALYST' => 'NO',
    'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO'
  }
  
  # Preserve both Debug and Release directories
  s.preserve_paths = 'Debug', 'Release'
  
  # Prepare command to set up the right frameworks before build
  s.prepare_command = 'if [ -d "Debug" ]; then echo "Setting up frameworks for simulator/debug builds"; mkdir -p Release-Backup; if [ ! -d "Release-Backup/App.xcframework" ]; then cp -R Release/*.xcframework Release-Backup/ 2>/dev/null || true; fi; else echo "Only Release frameworks available - create Debug frameworks with: flutter build ios-framework --debug --output=Debug/"; fi'
  
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  
  s.swift_version = '5.0'
  
  # Use Debug frameworks for simulator, Release for device
  s.ios.vendored_frameworks = 'Release/*.xcframework'
  
  s.script_phases = [
    {
      :name => 'Setup Flutter Frameworks for Platform',
      :script => 'echo "🔧 Platform: $PLATFORM_NAME, SDK: $SDK_NAME"; if [[ "$SDK_NAME" == *"simulator"* ]] && [ -d "${PODS_TARGET_SRCROOT}/Debug" ]; then echo "📱 Simulator - switching to Debug frameworks"; rm -rf "${PODS_TARGET_SRCROOT}/Release"/*.xcframework; cp -R "${PODS_TARGET_SRCROOT}/Debug"/*.xcframework "${PODS_TARGET_SRCROOT}/Release/"; echo "✅ Debug frameworks active in Release folder"; else echo "📱 Device - using Release frameworks"; if [ -d "${PODS_TARGET_SRCROOT}/Release-Backup" ]; then rm -rf "${PODS_TARGET_SRCROOT}/Release"/*.xcframework; cp -R "${PODS_TARGET_SRCROOT}/Release-Backup"/*.xcframework "${PODS_TARGET_SRCROOT}/Release/"; fi; echo "✅ Release frameworks active"; fi',
      :execution_position => :before_compile
    }
  ]
end
