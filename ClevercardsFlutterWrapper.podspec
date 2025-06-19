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
  
  # Only Swift wrapper source files - no vendored frameworks
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  s.swift_version = '5.0'
  
  # Depend on Flutter being integrated separately via direct integration
  s.dependency 'Flutter'
  
  # Documentation note about required setup
  s.prepare_command = 'echo "📋 SETUP REQUIRED: This wrapper requires Flutter to be integrated directly in your Podfile using install_all_flutter_pods(). See documentation for setup instructions."'
end
