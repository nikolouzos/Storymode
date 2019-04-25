//
//  Storage.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 12/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

/// Stores all the relevant information that we want to persist through app restarts
class Storage {
	// Singleton for the UserDefaults
	private static let defaults = UserDefaults()

	// Keys for the values we will be storing and retrieving
	private static let verificationIDKey = "verificationID"

	/// Stores the verificationID in the UserDefaults
	static func storeVerificationID() {
		if let verificationID = AppObjects.objects.verificationID {
			// If we have a verificationID, store it with its respective key
			defaults.set(verificationID, forKey: verificationIDKey)
		} else {
			log.error("Couldn't store the verificationID to the UserDefaults")
		}
	}

	/// Tries to retrieve the verificationID from the UserDefaults and stores
	/// it in the AppObjects
	static func retrieveVerificationID() {
		if let verificationID = defaults.string(forKey: verificationIDKey) {
			// Store the verificationID in the AppObjects
			AppObjects.objects.verificationID = verificationID
		} else {
			log.error("Could not retrieve a previous verificationID")
		}
	}
}
