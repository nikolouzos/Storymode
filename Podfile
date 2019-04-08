platform :ios, '10.0'

# Remove all pod related warnings
inhibit_all_warnings!

target 'StorymodeApp' do
  use_frameworks!

	# Firebase
	pod 'Firebase/Core'
	pod 'Firebase/Firestore'
	pod 'Firebase/Auth'

	# Crashlytics & Logging
	 pod 'Fabric', '~> 1.9.0'
	 pod 'Crashlytics', '~> 3.12.0'
	 pod 'SwiftyBeaver'

	# Views
	pod 'SideMenu'
	pod 'IBAnimatable'
	pod 'KVNProgress'

  target 'StorymodeAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'StorymodeAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

	# Remove the -pie warnings
	post_install do |installer|
		installer.pods_project.targets.each do |target|
			target.build_configurations.each do |config|
				config.build_settings['LD_NO_PIE'] = 'NO'
			end
		end
	end

end
