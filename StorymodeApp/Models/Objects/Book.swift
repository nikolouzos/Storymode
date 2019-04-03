//
//  Books.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 03/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

class Book {
	var id: String?
	var imageLink: String?
	var isPublic: Bool?
	var startingPage: String?
	var title: String?
	var price: Price?

	init(from dict: [String: Any]?, withID id: String?) {
		self.id = id
		imageLink = dict?["imageLink"] as? String
		isPublic = dict?["isPublic"] as? Bool
		startingPage = dict?["startingPage"] as? String
		title = dict?["title"] as? String

		if let priceDict = dict?["price"] as? [String: Any] {
			price = Price(from: priceDict)
		}
	}
}
