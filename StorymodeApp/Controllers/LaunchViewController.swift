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

	@IBOutlet weak var userLabel: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()
		// Hide the userLabel
		userLabel.isHidden = true
    }

	override func viewWillAppear(_ animated: Bool) {
		// Check if the user is authenticated
		if let userID = Auth.auth().currentUser?.uid {
			log.info("The user is already authenticated")

			// Start observing the user
//			if Firestore.user.userListener == nil {
//				// Start observing the user
//				Firestore.user.observeUser(withID: userID)
//			}

			// Set the delegate for the user
			Firestore.user.userDelegate = self
		} else {
			// Log that the user is not authenticated
			log.warning("The user is not authenticated")
		}
	}
}

extension LaunchViewController: UserDelegate {
	func observedUser(user: User?) {
		// If there's a user show their username in the userLabel
		if let user = user {
			userLabel.isHidden = false
			userLabel.text = "Welcome back, \(user.userID ?? "nil")"
		} else {
			userLabel.isHidden = true
		}
	}
}
