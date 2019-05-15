//
//  SplashViewController.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 16/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit
import FirebaseAuth

class LaunchViewController: UIViewController {

	@IBOutlet weak var authButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		// Check if the user is authenticated
		if let userID = Auth.auth().currentUser?.uid {
			log.info("The user is already authenticated")

			// Start observing the user if we are not already observing them
			if Firestore.user.userListener == nil {
				// Start observing the user
				Firestore.user.observeUser(withID: userID)
			}
		} else {
			// Log that the user is not authenticated
			log.warning("The user is not authenticated")
		}
	}
}
