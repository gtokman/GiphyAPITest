//
//  ViewController.swift
//  GiphyTestApp
//
//  Created by g tokman on 5/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	// MARK: - Properties
	@IBOutlet weak var imageView: UIImageView?
	@IBOutlet weak var searchTextField: UITextField?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	// MARK: - Helper

	func getGiph() {
		// Check textfield
		guard let searchField = searchTextField?.text where !searchField.isEmpty else {
			return
		}

		// Pass in search
		let giphySearch = GiphyAPI(search: searchField)

		// Make request
		giphySearch.getImageWithURL { data in
			print(data)
		}
	}

	// MARK: - Actions

	@IBAction func searchButtonPressed(sender: UIButton) {
		getGiph()
	}
}

