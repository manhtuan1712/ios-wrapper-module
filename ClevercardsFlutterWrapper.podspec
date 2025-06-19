Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.3.2'
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
  
  # Swift wrapper source files
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  s.swift_version = '5.0'
  
  # Preserve all build configuration directories
  s.preserve_paths = 'Debug', 'Profile', 'Release'
  
  # Create subspecs for different build configurations
  s.default_subspec = 'Release'
  
  s.subspec 'Debug' do |debug|
    debug.ios.vendored_frameworks = 'Debug/*.xcframework'
    debug.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'SUPPORTS_MACCATALYST' => 'NO',
      'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO',
      'FLUTTER_FRAMEWORK_DIR' => '$(PODS_TARGET_SRCROOT)/Debug'
    }
  end
  
  s.subspec 'Profile' do |profile|
    profile.ios.vendored_frameworks = 'Profile/*.xcframework'
    profile.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'SUPPORTS_MACCATALYST' => 'NO',
      'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO',
      'FLUTTER_FRAMEWORK_DIR' => '$(PODS_TARGET_SRCROOT)/Profile'
    }
  end
  
  s.subspec 'Release' do |release|
    release.ios.vendored_frameworks = 'Release/*.xcframework'
    release.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'SUPPORTS_MACCATALYST' => 'NO',
      'DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER' => 'NO',
      'FLUTTER_FRAMEWORK_DIR' => '$(PODS_TARGET_SRCROOT)/Release'
    }
  end
  
  s.prepare_command = 'echo "📋 IMPORTANT: Ensure you have both Debug and Release Flutter frameworks. Run flutter build ios-framework for both --debug and --release modes."'
end
