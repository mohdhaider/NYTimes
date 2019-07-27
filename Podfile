# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

inhibit_all_warnings!

def shared_pods
  pod 'Kingfisher'
end

target 'NYTimes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  shared_pods

  # Pods for NYTimes

  target 'NYTimesTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'NYTimesUITests' do
  inherit! :search_paths
  shared_pods
end
