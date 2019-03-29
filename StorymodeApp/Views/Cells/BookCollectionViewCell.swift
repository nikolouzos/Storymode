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
	@IBOutlet weak var lockImage: UIImageView!
	@IBOutlet weak var bookTitle: UILabel!

	var bookIsLocked: Bool?
	
	func setupBook(title: String, imagePath: String?, bookIsLocked: Bool) {
		// Set the bookTitle text
		bookTitle.text = title

		// Try to get the image for the imagePath
		// TODO: Will be added along with Firebase, for now we load a sample image
		bookCover.image = #imageLiteral(resourceName: "book-cover.jpg")

		// Update the views if the book is unlocked
		if !bookIsLocked { bookIsUnlocked() }
	}

	// Does an animation sequence upon clicking on the book

	// Hides the lockOverlay and lockImage if the book is unlocked
	func bookIsUnlocked() {
		lockOverlay.isHidden = true
		lockImage.isHidden = true
	}
}
