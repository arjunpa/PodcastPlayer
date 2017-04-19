//
//  SearchDefaultCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/18/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

class SearchDefaultCell: BaseCollectionCell {
 
    
    let kinterSpacingPadding:CGFloat = 10
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"backtotop")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()

    let titlelabel : UILabel = {
        let label = UILabel()
        label.text = "asdasdasfasf"
        label.numberOfLines = 1
        return label
    }()
    
    let descriptionlabel : UILabel = {
        let label = UILabel()
        label.text = "1234567890"
        label.numberOfLines = 1
        return label
    }()
    
    
    
   override func setupViews() {
        super.setupViews()
        let view = self.contentView
    view.addSubview(imageView)
    view.addSubview(titlelabel)
    view.addSubview(descriptionlabel)
    
    imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
    
    titlelabel.anchor(view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: kinterSpacingPadding, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
    descriptionlabel.anchor(titlelabel.bottomAnchor, left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: kinterSpacingPadding, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
    }
    
    
    override func configure(data: Any?) {
        print(data)
    }
}
