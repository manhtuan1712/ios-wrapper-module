Pod::Spec.new do |s|
  s.name             = 'ClevercardsFlutterWrapper'
  s.version          = '1.0.5'
  s.summary          = 'iOS wrapper for Clevercards Flutter module'
  s.homepage         = 'https://github.com/manhtuan1712/flutter-module'
  s.license          = { :type => 'MIT' }
  s.author           = { 'You' => 'manhtuan17121994@gmail.com' }
  s.source           = { :git => 'https://github.com/manhtuan1712/flutter-module.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.vendored_frameworks = 'Release/*.xcframework'
  s.source_files = 'iOSWrapper/*.{h,m,swift}'
  s.frameworks = 'UIKit', 'Flutter'
end
