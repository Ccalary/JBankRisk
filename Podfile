source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target ‘JBankRisk’ do
   pod 'Alamofire', '~> 4.0'
   pod 'SwiftyJSON'
   pod 'SnapKit', '~> 3.0.0'
   pod 'Kingfisher', '~> 3.0.0'
   pod 'MBProgressHUD', '~> 1.0.0'
   pod 'NJKWebViewProgress'
   pod 'AMapLocation'
   pod 'IQKeyboardManagerSwift'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

end
