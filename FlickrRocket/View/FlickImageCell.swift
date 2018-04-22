//
//  FlickImageCell.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import UIKit

class FlickImageCell: UICollectionViewCell {

    @IBOutlet weak var flickrImageView: CustomImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(forFlickrImage image: FlickrImage) {
        guard let url = image.imgUrl else {return}
        
        flickrImageView.loadImageFromUrlString(urlString: url)
    }

}
