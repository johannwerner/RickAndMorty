platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

# Workspace and project definition
workspace 'RickAndMorty'
project 'RickAndMorty.xcodeproj'

def shared_pods
    pod 'PureLayout', '3.1.4'
    pod 'RxCocoa', '5.0.0'
    # Network layer abstraction
    pod 'RxAlamofire', '5.0.0'
    pod 'Kingfisher', '5.7.1'
end


target 'RickAndMorty' do
    project 'RickAndMorty.xcodeproj'

    shared_pods
    target 'RickAndMortyTests' do
      inherit! :search_paths
    end
    
end

## Post actions

post_install do |installer|
    
    installer.pods_project.targets.each do |target|
        
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
            
            if [
                'R.swift.Library'
                ].include?(target.name)
                
                puts "Setting Swift version for #{target.name} to 5.0"
                
                config.build_settings['SWIFT_VERSION'] = '5.0'
            end

        end
        
    end
    
end
