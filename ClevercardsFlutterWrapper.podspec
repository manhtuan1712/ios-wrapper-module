Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.3.4'
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
  
  # Swift version
  s.swift_version = '5.0'
  
  # Preserve all build configuration directories
  s.preserve_paths = 'Debug', 'Profile', 'Release'
  
  # Exclude _CodeSignature directories to prevent sandbox issues
  s.exclude_files = '**/_CodeSignature/**'
  
  # Create subspecs for different build configurations
  s.default_subspec = 'Release'
  
  s.subspec 'Debug' do |debug|
    debug.source_files = 'iOSWrapper/*.{h,m,swift}'
    debug.ios.vendored_frameworks = 'Debug/*.xcframework'
    debug.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'SUPPORTS_MACCATALYST' => 'NO',
      'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO',
      'FLUTTER_FRAMEWORK_DIR' => '$(PODS_TARGET_SRCROOT)/Debug'
    }
  end
  
  s.subspec 'Profile' do |profile|
    profile.source_files = 'iOSWrapper/*.{h,m,swift}'
    profile.ios.vendored_frameworks = 'Profile/*.xcframework'
    profile.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'SUPPORTS_MACCATALYST' => 'NO',
      'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO',
      'FLUTTER_FRAMEWORK_DIR' => '$(PODS_TARGET_SRCROOT)/Profile'
    }
  end
  
  s.subspec 'Release' do |release|
    release.source_files = 'iOSWrapper/*.{h,m,swift}'
    release.ios.vendored_frameworks = 'Release/*.xcframework'
    release.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'SUPPORTS_MACCATALYST' => 'NO',
      'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO',
      'FLUTTER_FRAMEWORK_DIR' => '$(PODS_TARGET_SRCROOT)/Release'
    }
  end
  
  s.prepare_command = 'echo "📋 IMPORTANT: Ensure you have Debug, Profile, and Release Flutter frameworks."; echo "🧹 Cleaning up _CodeSignature directories..."; find . -name "_CodeSignature" -type d -exec rm -rf {} + 2>/dev/null || true; echo "✅ Clean frameworks ready for integration."'
end
