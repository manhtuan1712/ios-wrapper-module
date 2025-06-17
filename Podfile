# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

# Path to the Flutter module relative to this Podfile
flutter_module_path = '../../clevercard-module'

# Load Flutter module podhelper
load File.join(flutter_module_path, '.ios', 'Flutter', 'podhelper.rb')

target 'iOSWrapper' do
  use_frameworks!
  # Install Flutter pods
  install_all_flutter_pods(flutter_module_path)
end

# This post-install hook ensures Flutter compatible build settings
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Ensure minimum iOS version is 12.0 for pods
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
  
  # Apply Flutter-specific post-installation settings
  flutter_post_install(installer) if defined?(flutter_post_install)
end