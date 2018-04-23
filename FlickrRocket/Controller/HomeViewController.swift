//
//  ViewController.swift
//  FlickrRocket
//
//  Created by Fernando on 4/21/18.
//  Copyright © 2018 Specialist. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let networking = Networking.instance
    var flickrItems = [FlickrImage]()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: view.bounds.size.width - (view.bounds.size.width*0.1), height: 300)
//        }
        
        activityIndicator.frame = view.bounds
        activityIndicator.color = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        networking.fetch(route: .photos(tags: "cars")) { (data) in
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            guard let flickrJson = json as? NSDictionary,
                let photos = flickrJson["photos"] as? [String: Any],
                let photosArr = photos["photo"] as? [[String:Any]] else {return}
            
            DispatchQueue.main.async {
                for photo in photosArr {
                    let flickr = FlickrImage(photoObj: photo)
                    self.flickrItems.append(flickr)
                }
                
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flickrImageDetail" {
            if let destinationVC = segue.destination as? DetailVC{
                destinationVC.transitioningDelegate = self
                if let flickerItem = sender as? FlickrImage {
                    destinationVC.flickrItem = flickerItem
                }
            }
        }
    }

}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrItems.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrCell", for: indexPath) as? FlickImageCell else { return UICollectionViewCell()}
        
        let image = flickrItems[indexPath.row]
        cell.configureCell(forFlickrImage: image)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = flickrItems[indexPath.row]
        
        performSegue(withIdentifier: "flickrImageDetail", sender: image)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
        return CustomAnimationController()
    }
    
    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return CustomDismissAnimationController()
//    }
}
