source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

target 'worldcup-pops' do
  pod 'Alamofire'
  pod 'JASON'
  pod 'Kingfisher'
  pod 'SnapKit'
  pod 'FBSDKLoginKit'
  pod 'Firebase/Auth'
  pod 'FirebaseUI/Auth'
  pod 'Willow'
end

# After install, set VALID_ARCHS to arm64
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['VALID_ARCHS'] = 'arm64'
    end
  end
end
