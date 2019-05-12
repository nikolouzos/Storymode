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

//	// Keys for the values we will be storing and retrieving
//	private static let userIDKey = "userID"
//
//	/// Stores the userID in the UserDefaults
//	static func storeUserID() {
//		if let userID = AppObjects.objects.user?.userID {
//			// If we have a userID, store it with its respective key
//			defaults.set(userID, forKey: userIDKey)
//
//			log.info("Stored the userID (\(userID)) to the UserDefaults")
//		} else {
//			log.error("Couldn't store the userID to the UserDefaults. UserID not found.")
//		}
//	}
//
//	/// Tries to retrieve the userID from the UserDefaults and stores
//	/// it in the AppObjects
//	static func retrieveUserID() {
//		if let userID = defaults.string(forKey: userIDKey) {
//			// Store the userID in the AppObjects
//			AppObjects.objects.user = User(from: [:], withID: userID)
//
//			log.info("Retrieved the userID (\(userID)) to the UserDefaults")
//		} else {
//			log.error("Could not retrieve a previous userID")
//		}
//	}
}
