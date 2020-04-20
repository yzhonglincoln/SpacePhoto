//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Soft Dev on 3/5/20.
//  Copyright © 2020 Alice Zhong. All rights reserved.
//

import Foundation

// function for sending network request
class PhotoInfoController {
    func fetchPhotoInfo(completion: @escaping(PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!

        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            "date": "2020-03-07"
        ]

        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
                if let data = data,
                    let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                    completion(photoInfo)
                } else {
                    print("Either no data was returned, or data was not serialized.")
                    completion(nil)
                }
        }
        task.resume()
    }
}
