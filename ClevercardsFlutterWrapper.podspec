Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.1.0'
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
  
  s.ios.vendored_frameworks = 'Release/*.xcframework'
  
  # Preserve both Debug and Release directories
  s.preserve_paths = 'Debug', 'Release'
  
  s.prepare_command = 'if [ -d "Debug" ]; then echo "Debug frameworks available for simulator testing"; else echo "Only Release frameworks available - create Debug frameworks with: flutter build ios-framework --debug --output=Debug/"; fi'
  
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  
  s.swift_version = '5.0'
  
  s.script_phases = [
    {
      :name => 'Select Appropriate Flutter Frameworks',
      :script => 'echo "🔧 Script running - Platform: $PLATFORM_NAME, Configuration: $CONFIGURATION"; echo "🔍 Checking paths:"; echo "   PODS_TARGET_SRCROOT: ${PODS_TARGET_SRCROOT}"; echo "   Debug dir exists: $([ -d "${PODS_TARGET_SRCROOT}/Debug" ] && echo "YES" || echo "NO")"; ls -la "${PODS_TARGET_SRCROOT}" | head -10; if [[ "$PLATFORM_NAME" == "iphonesimulator"* ]] && [ -d "${PODS_TARGET_SRCROOT}/Debug" ]; then echo "📱 Using Debug frameworks for simulator"; rm -rf "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"/App.xcframework; rm -rf "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"/Flutter.xcframework; rm -rf "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"/FlutterPluginRegistrant.xcframework; cp -R "${PODS_TARGET_SRCROOT}/Debug"/*.xcframework "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/"; echo "✅ Debug frameworks copied"; else echo "📱 Using Release frameworks for device"; fi',
      :execution_position => :after_compile
    }
  ]
end
