Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.2.5'
  s.summary          = 'iOS wrapper for Clevercards Flutter module'
  s.homepage         = 'https://github.com/manhtuan1712/flutter-module'
  s.license          = { :type => 'MIT' }
  s.author           = { 'You' => 'manhtuan17121994@gmail.com' }
  s.source           = { :git => 'https://github.com/manhtuan1712/flutter-module.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.static_framework = true
  
  s.default_subspec = 'Release'
  
  s.subspec 'Release' do |release|
    release.vendored_frameworks = 'Release/*.xcframework'
    release.source_files = 'iOSWrapper/*.{h,m,swift}'
    release.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'SUPPORTS_MACCATALYST' => 'NO'
    }
  end
  
  s.subspec 'Debug' do |debug|
    debug.vendored_frameworks = 'Debug/*.xcframework'
    debug.source_files = 'iOSWrapper/*.{h,m,swift}'
    debug.pod_target_xcconfig = {
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'SUPPORTS_MACCATALYST' => 'NO',
      'CODE_SIGN_IDENTITY[sdk=iphonesimulator*]' => '',
      'ENABLE_BITCODE' => 'NO'
    }
  end
end
