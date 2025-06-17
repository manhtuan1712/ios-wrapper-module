Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.1.0'
  s.summary          = 'iOS wrapper for Clevercards Flutter module'
  s.homepage         = 'https://github.com/manhtuan1712/flutter-module'
  s.license          = { :type => 'MIT' }
  s.author           = { 'You' => 'manhtuan17121994@gmail.com' }
  s.source           = { :git => 'https://github.com/manhtuan1712/flutter-module.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  
  # Exclude Mac Catalyst to avoid framework compatibility issues
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'SUPPORTS_MACCATALYST' => 'NO',
    'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO'
  }
  
  # Use appropriate frameworks based on configuration
  s.vendored_frameworks = 'Release/*.xcframework'
  
  # Include wrapper source files
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  
  # Swift version
  s.swift_version = '5.0'
  
  # Copy debug frameworks for debug builds
  s.script_phases = [
    {
      :name => 'Setup Flutter Frameworks',
      :script => 'if [ "$CONFIGURATION" = "Debug" ] && [ -d "${PODS_TARGET_SRCROOT}/Debug" ]; then echo "Using debug Flutter frameworks for simulator"; rm -rf "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"/App.xcframework; rm -rf "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"/Flutter.xcframework; rm -rf "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"/FlutterPluginRegistrant.xcframework; cp -R "${PODS_TARGET_SRCROOT}/Debug"/*.xcframework "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/"; else echo "Using release Flutter frameworks"; fi',
      :execution_position => :after_compile
    }
  ]
end
