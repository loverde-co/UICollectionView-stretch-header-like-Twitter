//
//  AvatarImageView.swift
//  RecipesApp
//
//  Created by Daniel Arantes Loverde on 5/11/17.
//  Copyright © 2017 Loverde Co. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.layer.cornerRadius = (self.frame.size.width/2)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2.0
    }

}
