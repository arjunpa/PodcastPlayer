//
//  HeroImageElementCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype


class HeaderImageElementCell: BaseCollectionCell {
    
    let s = UIScreen.main.bounds.size.width - 32
    
    let kinterElementSpacing:CGFloat = 8
    let kmarginPadding:CGFloat = 16
    let imageBaseUrl = "https://" + (Quintype.publisherConfig?.cdn_image)! + "/"
    
    
    var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var bottomTitleTextLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 1
        return textLabel
        
    }()
    
    var bottomDescriptionTextLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        return textLabel
        
    }()
    
    var _imageViewHeightConstraint:NSLayoutConstraint?
    var imageViewHeightConstraint:NSLayoutConstraint{
        get{
            if _imageViewHeightConstraint != nil{
                self.imageView.removeConstraint(_imageViewHeightConstraint!)
                
            }
            
            self._imageViewHeightConstraint = NSLayoutConstraint.init(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
            self._imageViewHeightConstraint!.priority = 999
            self.imageView.addConstraint(_imageViewHeightConstraint!)
            return _imageViewHeightConstraint!
        }
        set{
            self._imageViewHeightConstraint = newValue
        }
    }
    
    override func setupView() {
        super.setupView()
        
        let view = self.contentView
        view.addSubview(imageView)
        view.addSubview(bottomTitleTextLabel)
        view.addSubview(bottomDescriptionTextLabel)
        
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: kmarginPadding, leftConstant: kmarginPadding, bottomConstant: 0, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
        
        bottomTitleTextLabel.anchor(imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: kinterElementSpacing, leftConstant: kmarginPadding, bottomConstant: 0, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
        
        bottomDescriptionTextLabel.anchor(bottomTitleTextLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: kinterElementSpacing, leftConstant: kmarginPadding, bottomConstant: kinterElementSpacing, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
        
    }
    
    
    
    override func configure(data:Any?){
        let story = data as? Story
        bottomTitleTextLabel.text = story?.sections.first?.display_name
        bottomDescriptionTextLabel.text = story?.headline
        //        self.imageView.image = UIImage()
        
        if let image = story?.hero_image_s3_key{
            let imageSize = calculateImageSize(metadata: story?.hero_image_metadata,width: s)
            imageViewHeightConstraint.constant = imageSize.height
            self.imageView.loadImage(url: imageBaseUrl + image + "?w=\(imageSize.width)", targetSize: imageSize,imageMetaData:(story?.hero_image_metadata))
        }
    }
}

func calculateImageSize(metadata:ImageMetaData?,width:CGFloat) -> CGSize{
    let widthDimension2 = width
    
    guard metadata != nil else {
        return CGSize.init(width: widthDimension2, height: widthDimension2 * 3.0/4.0)
    }
    
    if let width = metadata?.width, metadata!.height != nil{
        let widthDimenstion1 = CGFloat(width.floatValue)
        let heightDimension1 = CGFloat((metadata?.height!.floatValue)!)
        
        
        let heightDimenstion2 = widthDimension2 * heightDimension1/widthDimenstion1
        return CGSize.init(width: widthDimension2, height: heightDimenstion2)
    }
    return CGSize.init(width: widthDimension2, height: widthDimension2 * 3.0/4.0)
}
