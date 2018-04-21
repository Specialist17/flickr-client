//
//  FlickrItem.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import Foundation


struct FlickrImage {
    let farm: String
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String
    var imgUrl: String {
        // https://farm9.static.flickr.com/8111/8658536632_afab53f070.jpg
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
}
