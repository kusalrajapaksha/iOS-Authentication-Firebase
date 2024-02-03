# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CoffeeShop' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CoffeeShop
  
  # Add the Firebase pod for Google Analytics
  pod 'FirebaseAnalytics'

  # For Analytics without IDFA collection capability, use this pod instead
  # pod ‘Firebase/AnalyticsWithoutAdIdSupport’

  # Add the pods for any other Firebase products you want to use in your app
  # For example, to use Firebase Authentication and Cloud Firestore
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'GoogleSignIn'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
