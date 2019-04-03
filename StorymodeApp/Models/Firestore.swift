//
//  FirestoreBooks.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 03/04/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation
import Firebase

// MARK: - Firestore protocols
protocol BooksDelegate: class {
	func gotBooks(_ books: [Book])
}

class Firestore {
	// Singleton
	static let shared = Firestore()

	// MARK: - Books Observers
	var booksListener: ListenerRegistration?

	// Delegate for the books
	weak var booksDelegate: BooksDelegate?

	func observeBooks() {
		log.info("Added the booksListener")

		let booksRef = firestore.collection("books")
		
		booksListener = booksRef.whereField("isPublic", isEqualTo: true)
			.addSnapshotListener { snapshot, error in
				if let error = error {
					log.error("Error retrieving the PUBLIC books: \(error)")
				} else if let bookSnapshots = snapshot?.documents {
					log.info("Got the PUBLIC books")
					log.info("Parsing the PUBLIC books")
					var books = [Book]()
					for bookSnapshot in bookSnapshots {
						books.append(Book(from: bookSnapshot.data(), withID: bookSnapshot.documentID))
					}

					// Send the books to booksDelegate
					self.booksDelegate?.gotBooks(books)
				}
		}
	}
}
