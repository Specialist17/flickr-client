//
//  Networking.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import Foundation


enum Route {
    case post
    case comments(postId: Int)
    case me
    
    // Path
    func path() -> String {
        switch self {
        case .post:
            return "posts"
        case .comments:
            return "comments"
        case .me:
            return "users"
        }
    }
    // URL Parameters - query
    
    func urlParameters() -> [String: String] {
        switch self {
        case .post:
            return [:]
        case let .comments(postId):
            return ["search[postId]": "\(postId)", "page": "2"]
        case .me:
            return [:]
        }
    }
    
    // Headers
    
    func headers() -> [String: String] {
        return ["Authorization": "Bearer 0179e0017d2d4d388e62be3a6ddb5f5604c1512e6c47448fbd8d58ce6b2a82e7"]
    }
    // Body
    
    func body() -> Data? {
        switch self {
        case .post:
            return Data()
        default:
            return nil
        }
    }
}


class Networking {
    static let instance = Networking()
    
    let baseUrlString = "https://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=rocket&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1"
    let session = URLSession.shared
    
    func fetch(route: Route, completion: @escaping (Data) -> Void) {
        let fullUrlString = baseUrlString.appending(route.path())
        
        let url = URL(string: fullUrlString)!
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = route.headers()
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            completion(data)
        }.resume()
        
    }
}
