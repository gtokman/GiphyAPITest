//
//  Giphy.swift
//  GiphyTestApp
//
//  Created by g tokman on 5/15/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

struct GiphyAPI {
	var baseURL: String

	init(search: String) {
		baseURL = "http://api.giphy.com/v1/gifs/search?q=\(search)&api_key=dc6zaTOxFJmzC"
	}

	typealias GiphData = [String: AnyObject] -> ()

	// Create request
	func getImageWithURL(completionHandler: GiphData) {
		// Session
		let session = NSURLSession.sharedSession()

		// NSURL URL
		let url = NSURL(string: baseURL)

		// Request
		let request = NSURLRequest(URL: url!)

		// Data task with request
		let task = session.dataTaskWithRequest(request) { data, response, error in

			// Check error, Data, Response successful?
			guard error == nil,
				let data = data,
				let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
					print("Error: \(error)")
					return
			}

			var parsedResult = [String: AnyObject]()

			do {
				parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String: AnyObject]
				
			} catch {
				print("Parsing data: \(error)")
			}

			// Pass to completion
			completionHandler(parsedResult)
		}
		task.resume()
	}
}