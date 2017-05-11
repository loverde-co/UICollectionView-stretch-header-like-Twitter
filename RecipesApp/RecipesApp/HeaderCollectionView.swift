//
//  HeaderCollectionView.swift
//  RecipesApp
//
//  Created by Daniel Arantes Loverde on 5/9/17.
//  Copyright © 2017 Loverde Co. All rights reserved.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {
    
    @IBOutlet weak var lblHeaderCollection: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    //////////////////////////////////////////////////////////////////////////////
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
