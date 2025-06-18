Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.1.8'
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
  
  # Preserve both directories
  s.preserve_paths = 'Debug', 'Release'
  
  # Use Release frameworks by default
  s.ios.vendored_frameworks = 'Debug/*.xcframework'
  
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  s.swift_version = '5.0'
  
  # Simple post-install hook to inform about manual Debug setup
  s.post_install do |installer|
    puts "📱 ClevercardsFlutterWrapper installed!"
    puts "ℹ️  For SIMULATOR testing: manually change podspec to use Debug/*.xcframework"
    puts "ℹ️  For DEVICE testing: use Release/*.xcframework (default)"
  end
end
