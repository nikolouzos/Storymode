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
	
	func setupBook(title: String, imagePath: String?, bookIsLocked: Bool) {
		// Set the bookTitle text
		bookTitle.text = title

		// Try to get the image for the imagePath
		// TODO: Will be added along with Firebase, for now we load a sample image
		bookCover.image = #imageLiteral(resourceName: "book-cover.jpg")

		// Update the views if the book is unlocked
		self.bookIsLocked = bookIsLocked
		if !bookIsLocked { bookIsUnlocked() }

		// Add the action and selector for the
		// TODO: Finish the tap for the cell
		addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(onBookViewTap)))
	}

	// Handles the taps for the bookView
	@objc func onBookViewTap() {
		print("Tapped the bookView")

		// Do the corresponding animation
		doTapAnimation()
	}

	// Does an animation sequence upon clicking on the book
	func doTapAnimation() {
		// If the book is locked, just shake the lock
		if bookIsLocked {
			lockImage.animate(.shake(repeatCount: 1))
		} else {
			// TODO: Add the animation for the unlocked book tap
		}
	}

	// Hides the lockOverlay and lockImage if the book is unlocked
	func bookIsUnlocked() {
		// TODO: Instead of hiding the lockOverlay, make it lighter
		lockOverlay.isHidden = true
		lockImage.isHidden = true
	}
}
