//
//  FlickrItem.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import Foundation


struct FlickrImage {
    var farm: String
    var id: String
    var owner: String
    var secret: String
    var server: String
    var title: String
    var imgUrl: String {
        // https://farm9.static.flickr.com/8111/8658536632_afab53f070.jpg
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    init(photoObj: [String:Any]) {
        guard let farm = photoObj["farm"] as? String,
            let id = photoObj["id"] as? String,
            let owner = photoObj["owner"] as? String,
            let secret = photoObj["secret"] as? String,
            let server = photoObj["server"] as? String,
            let title = photoObj["title"] as? String
            else {
                self.farm = ""
                self.id = ""
                self.owner = ""
                self.secret = ""
                self.server = ""
                self.title = ""
                return
            }
        
        self.farm = farm
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.title = title
        
    }
    
}
