//
//  Networking.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import Foundation

class Networking {
    static let instance = Networking()
    
    let session = URLSession.shared
    
    func fetch(route: Route, completion: @escaping (Data) -> Void) {
        let baseUrl = route.baseURL()
        var toURL = URL(string: baseUrl)!
        toURL = toURL.appendingQueryParameters(_parametersDictionary: route.urlParameters())
        let request = URLRequest(url: toURL)
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {return}
            
            completion(data)
        }.resume()
        
    }
}
