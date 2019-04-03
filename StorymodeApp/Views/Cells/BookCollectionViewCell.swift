//
//  BookCollectionViewCell.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 30/03/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit
import IBAnimatable

class BookCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var bookView: AnimatableView!
	@IBOutlet weak var bookCover: AnimatableImageView!
	@IBOutlet weak var lockOverlay: AnimatableView!
	@IBOutlet weak var lockImage: AnimatableImageView!
	@IBOutlet weak var bookTitle: UILabel!
	var bookIsLocked = true
	
	func setupBook(title: String?, imagePath: String?, bookIsLocked: Bool) {
		// Set the bookTitle text
		bookTitle.text = title

		// Try to get the image for the imagePath
		// TODO: Will be added along with Firebase, for now we load a sample image
		bookCover.image = #imageLiteral(resourceName: "book-cover.jpg")

		// Update the views if the book is unlocked
		self.bookIsLocked = bookIsLocked
		if !bookIsLocked { bookIsUnlocked() }
	}

	// Does an animation sequence upon clicking on the book
	func doTapAnimation(completion: ()? = nil) {
		// If the book is locked, just shake the lock
		if bookIsLocked {
			bookView.animate(.shake(repeatCount: 1), duration: 0.35, damping: 0.8, velocity: 0.3, force: 0.5)
				.completion({
				log.debug("Finished the cell animation")

				// Run the completion block
				completion
			})
		} else {
			bookView.animate(.flip(along: .y)).completion({
				log.debug("Finished the cell animation")

				// Run the completion block
				completion
			})
		}
	}

	// Hides the lockOverlay and lockImage if the book is unlocked
	func bookIsUnlocked() {
		// TODO: Instead of hiding the lockOverlay, make it lighter
		lockOverlay.isHidden = true
		lockImage.isHidden = true
	}
}
