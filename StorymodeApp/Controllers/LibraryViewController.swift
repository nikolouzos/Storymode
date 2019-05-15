//
//  LibraryViewController.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 28/03/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	var books: [Book]?

	override func viewDidLoad() {
		super.viewDidLoad()

		// Set the booksDelegate
		Firestore.shared.booksDelegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Start observing for books
		Firestore.shared.observeBooks()
	}

	override func viewDidDisappear(_ animated: Bool) {
		// TODO: Change this when we create the next pages
		// Remove the booksListener
		log.info("Removed the booksListener")
		Firestore.shared.booksListener?.remove()
	}
}

// MARK: - Collection View Customization
extension LibraryViewController: UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return books?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView
			.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCollectionViewCell {
			// Try to create the cell from the book data
			if let book = books?[indexPath.row] {
				// Set the state of the book
				var bookIsLocked = true
				// Unlock the book
				if let startingPage = book.startingPage, startingPage != "" {
					bookIsLocked = false
				}

				// Initialize the cell
				cell.setupBook(title: book.title, imagePath: book.imageLink, bookIsLocked: bookIsLocked)
			}

			return cell
		}
		return UICollectionViewCell()
	}

	// Use equal spacing for the cells on the screen
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		// MARK: - Default cell width
		let cellWidth: CGFloat = 160
		let cellCountInRow = CGFloat(Int(collectionView.frame.size.width / cellWidth))
		let totalSpace = collectionView.frame.size.width - cellCountInRow * cellWidth

		// We divide the totalSpace by the number of cells in each row -1
		// And add 2 for the left and right spacing
		let finalSpacing = totalSpace / (cellCountInRow - 1 + 2)
		return UIEdgeInsets(top: 0, left: finalSpacing, bottom: 0, right: finalSpacing)
	}

	// Handles the cell taps
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// Create the cell
		if let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell {
			// Do the tap animation
			cell.doTapAnimation()

			// TODO: Add the rest of the functionality
		}
	}
}

// MARK: - Books Delegate
extension LibraryViewController: BooksDelegate {
	func gotBooks() {
		self.books = AppObjects.objects.books

		// Reload the collectionView with the updates
		collectionView.reloadData()
	}
}
