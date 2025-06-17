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
  
  s.prepare_command = <<-CMD
    if [ -d "Debug" ]; then
      echo "Debug frameworks available for simulator testing"
    else
      echo "Only Release frameworks available - create Debug frameworks with: flutter build ios-framework --debug --output=Debug/"
    fi
  CMD
  
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  
  s.swift_version = '5.0'
  
  s.script_phases = [
    {
      :name => 'Select Appropriate Flutter Frameworks',
      :script => <<-SCRIPT
        # Check if we're building for simulator and Debug frameworks exist
        if [[ "$PLATFORM_NAME" == "iphonesimulator"* ]] && [ -d "${PODS_TARGET_SRCROOT}/Debug" ]; then
          echo "📱 Simulator build detected - using Debug frameworks (with kernel_blob.bin)"
          # Remove release frameworks that were copied
          find "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}" -name "*.xcframework" -exec rm -rf {} + 2>/dev/null || true
          # Copy debug frameworks
          cp -R "${PODS_TARGET_SRCROOT}/Debug"/*.xcframework "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/" 2>/dev/null || true
        else
          echo "📱 Device build detected - using Release frameworks (native code)"
          # Release frameworks are already copied by vendored_frameworks
        fi
      SCRIPT
      ,
      :execution_position => :after_compile
    }
  ]
end
