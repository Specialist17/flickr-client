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
    @IBOutlet weak var authorImageView: UIImageView!
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
                let ownerUsername = ownerInfo["username"] as? String else {return}
            
            DispatchQueue.main.async {
                self.authorNameLabel.text = ownerUsername
                self.photoTitleLabel.text = photoTitleContent
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
