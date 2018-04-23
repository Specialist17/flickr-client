//
//  FlickrItem.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import Foundation


struct FlickrImage {
    var farm: Int
    var id: String
    var owner: String
    var secret: String
    var server: String
    var title: String
    var imgUrl: String?
    
    init(photoObj: [String:Any]) {
        guard let farm = photoObj["farm"] as? Int,
            let id = photoObj["id"] as? String,
            let owner = photoObj["owner"] as? String,
            let secret = photoObj["secret"] as? String,
            let server = photoObj["server"] as? String,
            let title = photoObj["title"] as? String
            else {
                self.farm = 0
                self.id = ""
                self.owner = ""
                self.secret = ""
                self.server = ""
                self.title = ""
                self.imgUrl = nil
                return
            }
        
        self.farm = farm
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.title = title
        self.imgUrl = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
}
