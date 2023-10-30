project '/Users/lydia/Desktop/Demo0819/Demo0819.xcodeproj'

platform :ios, '13.6'
target 'Demo0819' do
	use_frameworks!
	pod 'Firebase/Core'
	pod 'Firebase/Database'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['OTHER_CFLAGS'] = '$(inherited) -w'
    end
  end
end
