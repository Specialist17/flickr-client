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
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageUrl = imageUrl {
             flickrDetailImageView.loadImageFromUrlString(urlString: imageUrl)
        }
        // Do any additional setup after loading the view.
        
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
