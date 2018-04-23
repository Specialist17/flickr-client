//
//  DetailVC.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var flickrDetailImageView: CustomImageView!
    @IBOutlet weak var authorImageView: CustomImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var photoTitleLabel: UILabel!
    var flickrItem: FlickrImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = flickrItem.imgUrl {
             flickrDetailImageView.loadImageFromUrlString(urlString: imageUrl)
        }
        
        Networking.instance.fetch(route: .photoInfo(photoId: flickrItem.id)) { (data) in
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else {return}
            
            guard let photoInfo = json!["photo"] as? [String:Any],
                let photoTitle = photoInfo["title"] as? [String:Any],
                let photoTitleContent = photoTitle["_content"] as? String,
                let ownerInfo = photoInfo["owner"] as? [String: Any],
                let ownerFarm = ownerInfo["iconfarm"] as? Int,
                let ownerSever = ownerInfo["iconserver"] as? String,
                let ownerId = ownerInfo["nsid"] as? String,
                let ownerUsername = ownerInfo["username"] as? String else {return}
            
            
            DispatchQueue.main.async {
                self.authorNameLabel.text = ownerUsername
                self.photoTitleLabel.text = photoTitleContent
                var urlString = ""
                if ownerFarm > 0 {
                    urlString = "http://farm\(ownerFarm).staticflickr.com/\(ownerSever)/buddyicons/\(ownerId).jpg"
                } else {
                    urlString = "https://www.flickr.com/images/buddyicon.gif"
                }
                self.authorImageView.loadImageFromUrlString(urlString: urlString)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissDetailPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
