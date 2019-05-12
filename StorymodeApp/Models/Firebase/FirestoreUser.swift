//
//  FirestoreUser.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 30/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation
import Firebase

// MARK: FirestoreUser Protocols
protocol UserCreationDelegate: class {
	func createdUserWithID(_ userID: String?)
}

protocol UserDelegate: class {
	func observedUser(user: User?)
}

class FirestoreUser: Firestore {
	// MARK: - Books Listeners
	var userListener: ListenerRegistration?

	// Verification Code delegate
	weak var userCreationDelegate: UserCreationDelegate?

	/// Creates a user with the specified userID and bookIDs
	func createUser(with userID: String, and ownedBookIDs: [String]) {
		// Add the user to the database
		firestore.collection("users")
			.document(userID).setData([
				"id": userID,
				"isPremium": false,
				"ownedBooks": ownedBookIDs
			]) { error in
				if let error = error {
					log.error("""
						We encountered an error while adding the user in the database
						\n Error: \(error.localizedDescription)
						""")
				} else {
					log.info("Added the user to the database")

					// Call the delegate for the user sign in
					Firestore.user.userCreationDelegate?.createdUserWithID(userID)
				}

				// Call the delegate for the user sign in
				Firestore.user.userCreationDelegate?.createdUserWithID(nil)
		}
	}

	// User observer delegate
	weak var userDelegate: UserDelegate?

	/// Retrieves the user with the specified userID (aka verificationID)
	func observeUser(withID userID: String) {
		let userRef = firestore.collection("users").document(userID)

		userListener = userRef.addSnapshotListener { (snapshot, error) in
			// If there's an error, log it and make the user nil
			if let error = error {
				log.error("We couldn't find the user in the database\n Error \(error.localizedDescription)")

				// Make the user nil and call the delegate
				AppObjects.objects.user = nil

				// Call the delegate while passing a nil user
				Firestore.user.userDelegate?.observedUser(user: nil)
			} else if let userDict = snapshot?.data() {
				// If there's no error, create and assign the user
				let user = User(from: userDict, withID: userID)

				// Assign the user
				AppObjects.objects.user = user

				// Call the delegate
				Firestore.user.userDelegate?.observedUser(user: user)
			} else {
				// If there's no user and no error, log the error
				log.error("""
					We couldn't find a user in the database, but there was no error.
					Did you call Firestore.user.observeUser() correctly?
					""")
				Firestore.user.userDelegate?.observedUser(user: nil)
			}
		}
	}
}
