//
//  ViewController.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 28/03/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	let totalCells = 3

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
}

// MARK: - Collection View Customization
extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return totalCells
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView
			.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BookCollectionViewCell {
			if indexPath.row == 1 {
				cell.setupBook(title: "UnlockedBook", imagePath: nil, bookIsLocked: false)
			} else {
				cell.setupBook(title: "LockedBook", imagePath: nil, bookIsLocked: true)
			}

			return cell
		}
		return UICollectionViewCell()
	}

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
}
