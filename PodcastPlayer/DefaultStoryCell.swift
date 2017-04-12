//
//  DefaultStoryCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/11/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype


class DefaultStoryCell: BaseCollectionCell {
    
    let kinterElementSpacing:CGFloat = 8
    let kmarginPadding:CGFloat = 16
    let imageBaseUrl = "https://" + (Quintype.publisherConfig?.cdn_image)! + "/"

    
    var imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    var headerLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    var descriptionLabel : UILabel = {
       let label = UILabel()
        label.numberOfLines = 4
        return label
    }()
    
    var _imageHeightConstraint : NSLayoutConstraint!
    var imageHeightConstraint : NSLayoutConstraint {
        get{
            if _imageHeightConstraint == nil{
             _imageHeightConstraint = NSLayoutConstraint(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
                self._imageHeightConstraint.priority = 999
                self.imageView.addConstraint(_imageHeightConstraint)
            }
            return _imageHeightConstraint
        }
        set{
            _imageHeightConstraint = newValue
        }
    }
    
    override func setupView() {
        let view = self.contentView
        view.addSubview(imageView)
        view.addSubview(headerLabel)
        view.addSubview(descriptionLabel)
        
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: kmarginPadding, leftConstant: kmarginPadding, bottomConstant: kmarginPadding, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        imageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width/2) - kmarginPadding).isActive = true
        
        headerLabel.anchor(view.topAnchor, left: imageView.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: kmarginPadding, leftConstant: kinterElementSpacing, bottomConstant: 0, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
        descriptionLabel.anchor(headerLabel.bottomAnchor, left: imageView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: kmarginPadding, leftConstant: kinterElementSpacing, bottomConstant: kmarginPadding, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
    }
    
    override func configure(data: Any?) {
        let story = data as? Story
        
        headerLabel.text = story?.sections.first?.display_name
        descriptionLabel.text = story?.headline
        
       if let imageKey = story?.hero_image_s3_key{
            let imageSize = calculateImageSize(metadata: story?.hero_image_metadata, width: (UIScreen.main.bounds.width/2) - kmarginPadding)
        imageHeightConstraint.constant = imageSize.height
        self.imageView.loadImage(url: self.imageBaseUrl + imageKey + "?w=\(imageSize.width)", targetSize: imageSize, imageMetaData: story?.hero_image_metadata)
        }
        
    }
    

    
}
