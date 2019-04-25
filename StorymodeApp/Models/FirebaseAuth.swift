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

					// Store the verificationID in the UserDefaults
					Storage.storeVerificationID()
				}
			}

			// Call the delegate with an error
			self.phoneAuthDelegate?.verifiedPhone(withError: error)
		}
	}

	/// Checks the verification code that was provided by the user.
	/// If the code is  valid, it returns the userID
	func checkVerificationCode(_ code: String) {
		if let verificationID = AppObjects.objects.verificationID {
			// Create the user credentials
			let credential = PhoneAuthProvider.provider().credential(
				withVerificationID: verificationID, verificationCode: code)

			// Sign in the user
			Auth.auth().signInAndRetrieveData(with: credential) { (result, error) in
				if let error = error {
					log.error("Got an error while signing in the user: \(error.localizedDescription)")

					// Call the delegate for the user sign in
					Firestore.shared.verificationCodeDelegate?.checkedVerificationCode(userID: nil)
				} else if let user = result?.user {
					log.info("Authenticated the user, will now add a user in the database")

					// Create the books we need to send to user to create their profile
					let freeBooks = AppObjects.objects.books.filter({ $0.price?.finalPrice == "0" })
					var freeBookIDs = [String]()
					for book in freeBooks {
						freeBookIDs.append(book.id ?? "")
					}

					// Add the user to the database
					Firestore.shared.createUser(with: user.uid, and: freeBookIDs)
				}
			}
		} else {
			log.error("An unexpected error occured while checking the user's verification code.")
			// TODO: Add the error dialog
		}
	}
}
