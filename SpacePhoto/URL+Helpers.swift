//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Soft Dev on 3/5/20.
//  Copyright © 2020 Alice Zhong. All rights reserved.
//

import Foundation

// URL extension
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
            {URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
    }
}
