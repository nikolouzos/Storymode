//
//  User.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 03/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

class User {
	var userID: String?
	var isPremium: Bool?
	var ownedBooks: [String]?

	init(from dict: [String: Any], with userID: String) {
		self.userID = userID
		isPremium = dict["isPremium"] as? Bool
		ownedBooks = dict["ownedBooks"] as? [String]
	}
}
