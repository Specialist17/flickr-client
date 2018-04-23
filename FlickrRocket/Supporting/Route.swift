//
//  Route.swift
//  FlickrRocket
//
//  Created by Fernando on 4/22/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import Foundation

enum Route {
    case photos(tags: String)
    case photoInfo(photoId: String)
    case userImg(iconFarm: Int, iconServer: String, nsid: String)
    
    // Path
    func method() -> String {
        switch self {
        case .photos:
            return "flickr.photos.search"
        case .photoInfo:
            return "flickr.photos.getInfo"
        case .userImg:
            return ""
        }
    }
    // URL Parameters - query
    
    func urlParameters() -> [String: String] {
        switch self {
        case let .photos(tags):
            return ["format": "json",
                    "sort": "random",
                    "method": method(),
                    "tags": tags,
                    "tag_mode": "all",
                    "api_key": "0e2b6aaf8a6901c264acb91f151a3350",
                    "nojsoncallback": "1",]
        case let .photoInfo(photoId):
            return ["format": "json",
                    "sort": "random",
                    "method": method(),
                    "api_key": "0e2b6aaf8a6901c264acb91f151a3350",
                    "photo_id": photoId,]
        case .userImg:
            return [:]
        }
    }
    
    func baseURl() -> String {
        switch self {
        case .photos, .photoInfo:
            return "https://api.flickr.com/services/rest/"
        case let .userImg(iconFarm, iconServer, nsid):
            return "http://farm\(iconFarm).staticflickr.com/\(iconServer)/buddyicons/\(nsid).jpg"
        }
    }
    
    // Headers
    
    func headers() -> [String: String] {
        return [:]
    }
}
