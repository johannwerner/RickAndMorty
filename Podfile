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
