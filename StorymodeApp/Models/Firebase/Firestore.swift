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

class Firestore {
	// Singleton
	static let shared = Firestore()
	static let user = FirestoreUser()

	// MARK: - Books Listeners
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

					// Add the books to the appObjects
					AppObjects.objects.books = books

					// Send the books to booksDelegate
					self.booksDelegate?.gotBooks()
				}
		}
	}

	/// Removes all the listeners persistent listeners that have been created
	/// This function is normally called only when the application enters the background
	// Persistent in this context means listeners that have been created at or close
	// to the start of the application and have not been removed since. Thus listeners
	// that are used throughout the lifecycle of the application e.g. UserListener
	func removePersistentListeners() {
		Firestore.user.userListener?.remove()
	}

	/// Restarts all the persistent listeners
	/// This function is normally called only when the application enters the foreground
	func restartPersistentListeners() {
		if let userID = Auth.auth().currentUser?.uid {
			Firestore.user.observeUser(withID: userID)
		}
	}
}
