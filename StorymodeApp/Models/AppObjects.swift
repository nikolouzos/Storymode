//
//  AppObjects.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 16/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

class AppObjects {
	static var objects = AppObjects()

	var verificationID: String?
	var user: User?
	var books: [Book] = []
}
