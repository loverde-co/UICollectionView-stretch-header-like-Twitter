//
//  ViewController.swift
//  RecipesApp
//
//  Created by Daniel Arantes Loverde on 5/9/17.
//  Copyright © 2017 Loverde Co. All rights reserved.
//

import UIKit

let offset_HeaderStop:CGFloat = 20.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 42.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 50.0 // The distance between the bottom of the Header and the top of the White Label

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btMenu: UIButton!
    var imageViewHeader: UIImageView!
    var imageBlurHeader: UIImageView!
    
    // Instantiate custom Header Collection
    
    var headerCollection : HeaderCollectionView! = HeaderCollectionView()
    
    //Dummy Array
    
    let testArray: [[String:String]] = [["image" : "http://dev.image.inshakeapp.com/recipe-242.png", "name" : "Plátano y tiramisú - Imagen", "time" : "3"],
                                          ["image" : "http://dev.image.inshakeapp.com/recipe-168.png", "name" : "Yogur y piel de naranja-V+IMA", "time" : "3"],
                                          ["image" : "http://dev.image.inshakeapp.com/recipe-168.png", "name" : "Yogur y piel de naranja-V+IMA", "time" : "3"],
                                          ["image" : "http://dev.image.inshakeapp.com/recipe-168.png", "name" : "Yogur y piel de naranja-V+IMA", "time" : "3"],
                                          ["image" : "http://dev.image.inshakeapp.com/recipe-168.png", "name" : "Yogur y piel de naranja-V+IMA", "time" : "3"],
                                          ["image" : "http://dev.image.inshakeapp.com/recipe-168.png", "name" : "Yogur y piel de naranja-V+IMA", "time" : "3"],
                                          ["image" : "http://dev.image.inshakeapp.com/recipe-168.png", "name" : "Yogur y piel de naranja-V+IMA", "time" : "3"],
                                          ["image" : "http://dev.image.inshakeapp.com/recipe-168.png", "name" : "Yogur y piel de naranja-V+IMA", "time" : "3"],
                                          ["image" : "http://dev.image.inshakeapp.com/recipe-168.png", "name" : "Yogur y piel de naranja-V+IMA", "time" : "3"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        // Change Z Position of Burger Button to not stay behinde header
        self.btMenu.layer.zPosition = 3
        
        // Create header image
        imageViewHeader = UIImageView(frame: headerView.bounds)
        imageViewHeader?.image = UIImage(named: "HeaderBG")
        imageViewHeader?.contentMode = UIViewContentMode.scaleAspectFill
        headerView.insertSubview(imageViewHeader, belowSubview: lblHeader)
        
        // Create a blurred image
        imageBlurHeader = UIImageView(frame: headerView.bounds)
        imageBlurHeader?.image = UIImage(named: "HeaderBG")?.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
        imageBlurHeader?.contentMode = UIViewContentMode.scaleAspectFill
        imageBlurHeader?.alpha = 0.0
        headerView.insertSubview(imageBlurHeader, belowSubview: lblHeader)
        
        headerView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        //DOWN SCROLL
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
        //UP SCROLL
        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
            lblHeader.layer.transform = labelTransform
            
            imageBlurHeader?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / headerCollection.imgAvatar.bounds.height / 1.4
            let avatarSizeVariation = ((headerCollection.imgAvatar.bounds.height * (1.0 + avatarScaleFactor)) - headerCollection.imgAvatar.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            
            //Change Header Z postion
            if offset <= offset_HeaderStop {
                
                if headerCollection.imgAvatar.layer.zPosition < headerView.layer.zPosition{
                    headerView.layer.zPosition = 0
                }
                
            }else {
                if headerCollection.imgAvatar.layer.zPosition >= headerView.layer.zPosition{
                    headerView.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformation
        headerView.layer.transform = headerTransform
        headerCollection.imgAvatar.layer.transform = avatarTransform
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.testArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCellCollectionCell", for: indexPath) as! ListCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.testArray.count{
            // loadMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // Setting custom Header for CollectionView
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            self.headerCollection = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "idHeaderCollectionReusable", for: indexPath) as! HeaderCollectionView
            
            return self.headerCollection
            
            
        default:  fatalError("Unexpected element kind")
        }
    }
}

