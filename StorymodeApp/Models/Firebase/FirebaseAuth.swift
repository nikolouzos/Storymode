//
//  FirebaseAuth.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 12/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol PhoneAuthDelegate: class {
	func verifiedPhone(withError error: Error?)
}

protocol VerificationCodeDelegate: class {
	func verifiedCodeWith(_ userID: String?)
}

class FirebaseAuth {
	// Singleton
	static var auth = FirebaseAuth()

	// Phone Authentication Delegate
	weak var phoneAuthDelegate: PhoneAuthDelegate?

	/// Try to authenticate the user with the phone number they have provided
	func authPhone(_ phone: String) {
		PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { (verificationID, error) in
			if let error = error {
				log.error("Got an error while verifying the phone: \(error.localizedDescription)")
			} else {
				// Store the verificationID for future usage
				if let verificationID = verificationID {
					// Store the verificationID in the AppObjects
					AppObjects.objects.verificationID = verificationID
				}
			}

			// Call the delegate with an error
			self.phoneAuthDelegate?.verifiedPhone(withError: error)
		}
	}

	// MARK: - Verification Code Delegate
	weak var verificationCodeDelegate: VerificationCodeDelegate?

	/// Checks the verification code that was provided by the user.
	/// If the code is  valid, it returns the userID
	func checkVerificationCode(_ code: String) {
		if let verificationID = AppObjects.objects.verificationID {
			// Create the user credentials
			let credential = PhoneAuthProvider.provider().credential(
				withVerificationID: verificationID, verificationCode: code)

			// Sign in the user
			Auth.auth().signIn(with: credential) { (result, error) in
				if let error = error {
					log.error("Got an error while signing in the user: \(error.localizedDescription)")

					// Call the delegate for the code verification
					FirebaseAuth.auth.verificationCodeDelegate?.verifiedCodeWith(nil)
				} else if let user = result?.user {
					log.info("Verified the verification code, will now check if the user extists or add the user to the database")

					// Call the delegate for the code verification
					FirebaseAuth.auth.verificationCodeDelegate?.verifiedCodeWith(user.uid)
				}
			}
		} else {
			log.error("An unexpected error occured while checking the user's verification code.")
			// TODO: Add the error dialog
		}
	}
}
