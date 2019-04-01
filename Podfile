platform :ios, '10.0'

# Remove all pod related warnings
inhibit_all_warnings!

target 'StorymodeApp' do
  use_frameworks!

	# Firebase
	pod 'Firebase/Core'
	pod 'Firebase/Firestore'

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

end
