Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.0.9'
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
  
  # Include all Flutter frameworks
  s.vendored_frameworks = 'Release/*.xcframework'
  
  # Include wrapper source files
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  
  # Swift version
  s.swift_version = '5.0'
end
