//
//  StoryDetailImageElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/1/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailImageElementCell: BaseCollectionCell {
    
    let imageBaseUrl = "https://" + (Quintype.publisherConfig?.cdn_image)! + "/"
    
    let screenWidth = UIScreen.main.bounds.width
    
    let imageView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    
    let imageTextDesctiptionLayer:UIView = {
        
        let view = UIView()
        view.backgroundColor = Themes.storyDetailCells.storyDetailImageElementCell.imageDescriptionLayerColor
        view.alpha = Themes.storyDetailCells.storyDetailImageElementCell.imageDescriptionLayerOpacity
        return  view
        
    }()
    
    
    let imageTextDescription:UILabel = {
        
        let label = UILabel()
        label.font = Themes.storyDetailCells.storyDetailImageElementCell.imageDescriptionFontSize
        label.numberOfLines = 4
        label.textColor = Themes.storyDetailCells.storyDetailImageElementCell.imageDescriptionFontColor
        label.lineBreakMode = .byWordWrapping
        return label
        
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
    
    
    func calculateImageSize(metadata:ImageMetaData?) -> CGSize{
        let widthDimension2 = UIScreen.main.bounds.size.width
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
    
    override func setupViews() {
        
         let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(imageView)
        imageView.addSubview(imageTextDesctiptionLayer)
        imageView.addSubview(imageTextDescription)
        
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant:screenWidth , heightConstant: 0)
        
        imageTextDesctiptionLayer.anchor(nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        
        imageTextDescription.anchor(nil, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 5, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        // image tap configured in StoryPager
        
        
    }
    
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let image =  card?.image_s3_key{
            
            let imageSize = self.calculateImageSize(metadata: card?.hero_image_metadata)
            
            self.imageViewHeightConstraint.constant = imageSize.height
            
            imageView.loadImage(url: imageBaseUrl + image + "?w=\(imageSize.width)", targetSize: CGSize(width: imageView.frame.width, height: imageView.frame.height),imageMetaData:(card?.hero_image_metadata))
            
            if let imageDescription = card?.title{
                imageView.accessibilityLabel = imageBaseUrl + image
                    imageTextDescription.text = imageDescription
                
            }
        }
        
       
    }
    
}
