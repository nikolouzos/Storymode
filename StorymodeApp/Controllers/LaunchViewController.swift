//
//  SplashViewController.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 16/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		// Try to retrieve the verificationID
		Storage.retrieveVerificationID()
    }
}
