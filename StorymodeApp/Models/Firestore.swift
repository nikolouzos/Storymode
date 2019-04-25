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
	func gotBooks()
}

protocol VerificationCodeDelegate: class {
	func checkedVerificationCode(userID: String?)
}

class Firestore {
	// Singleton
	static let shared = Firestore()

	// MARK: - Books Observers
	var booksListener: ListenerRegistration?

	// Verification Code delegate
	weak var verificationCodeDelegate: VerificationCodeDelegate?

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

					// Add the books to the appObjects
					AppObjects.objects.books = books

					// Send the books to booksDelegate
					self.booksDelegate?.gotBooks()
				}
		}
	}

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
					self.verificationCodeDelegate?.checkedVerificationCode(userID: userID)
				}

				// Call the delegate for the user sign in
				self.verificationCodeDelegate?.checkedVerificationCode(userID: nil)
		}
	}
}
