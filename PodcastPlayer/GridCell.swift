//
//  GridCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/18/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

class GridCell: BaseCollectionCell {
    
    let kMarginPadding:CGFloat = 0

    let imageView:UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named:"author")
        image.clipsToBounds = true
        return image
    }()
    
    let label: InsetLabel = {
       let label = InsetLabel()
        label.leftInset = 0
        label.numberOfLines = 2
        label.text = "Dibiya"
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        let view = self.contentView
        view.addSubview(imageView)
        view.addSubview(label)
        
        self.imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: kMarginPadding, leftConstant: kMarginPadding, bottomConstant: 0, rightConstant: kMarginPadding, widthConstant: 100, heightConstant: 100)
        
        self.label.anchor(self.imageView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: kMarginPadding, leftConstant: kMarginPadding, bottomConstant: kMarginPadding, rightConstant: kMarginPadding, widthConstant: 0, heightConstant: 0)
    }
    
    
    override func configure(data: Any?) {
        
    }
    
}
