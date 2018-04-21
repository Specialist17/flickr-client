//
//  ViewController.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let networking = Networking.instance
    var flickrItems = [FlickrImage]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
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
                
                let flickr = FlickrImage(photoObj: photo)
                self.flickrItems.append(flickr)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrCell", for: indexPath) as? FlickImageCell else { return UICollectionViewCell()}
        
        
        return cell
        
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}
