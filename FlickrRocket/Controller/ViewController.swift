//
//  ViewController.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let networking = Networking.instance
    var flickrItems = [FlickrImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        networking.fetch(route: .me) { (data) in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            guard let flickrJson = json as? NSDictionary,
                let photos = flickrJson["photos"] as? [String: Any],
                let photosArr = photos["photo"] as? [[String:Any]] else {return}
            
            print(photosArr)
            
            for photo in photosArr {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

