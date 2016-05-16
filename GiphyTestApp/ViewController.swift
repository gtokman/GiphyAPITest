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
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	// MARK: - Helper

	func performUIUpdatesOnMain(updates: () -> Void) {
		dispatch_async(dispatch_get_main_queue()) {
			updates()
		}
	}

	func getGiphURL(completion: String -> ()) {
		// Check textfield
		guard let searchField = searchTextField?.text where !searchField.isEmpty else {
			return
		}

		// Pass in search
		let giphySearch = GiphyAPI(search: searchField)

		// Make request
		giphySearch.getImageWithURL { giphyData in

			guard let data = giphyData["data"] as? [AnyObject],
				let firstGiphy = data.first as? [String: AnyObject],
				let imageData = firstGiphy["images"] as? [String: AnyObject],
				let image = imageData["downsized_large"] as? [String: AnyObject],
				let url = image["url"] as? String
			else {
				return
			}

			print(url)

			completion(url)
		}
	}

	func convertToImage() {
		// Convert URL to ImageView // Used extension from Github https://github.com/kiritmodi2702/GIFIamgeView_Swift to animate

		getGiphURL { (url) in
			let imageURL = NSURL(string: url)

			if let imageData = NSData(contentsOfURL: imageURL!) {
				self.performUIUpdatesOnMain({
					self.imageView?.image = UIImage.animatedImageWithAnimatedGIFData(imageData)
					self.activityIndicator.stopAnimating()
				})
			} else {
				print("Convert image error")
			}
		}
	}

	// MARK: - Actions

	@IBAction func searchButton(sender: UIButton) {
		activityIndicator.hidden = false
		activityIndicator.startAnimating()
		convertToImage()
	}
}

