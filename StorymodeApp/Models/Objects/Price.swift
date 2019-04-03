//
//  Price.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 03/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

class Price {
	var startingPrice: String?
	var finalPrice: String?

	init(from dict: [String: Any]?) {
		startingPrice = dict?["startingPrice"] as? String
		finalPrice = dict?["finalPrice"] as? String
	}
}
