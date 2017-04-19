//
//  CollectionViewCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/27/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailHeaderImageElementCell: BaseCollectionCell {
    
    var coverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
        
        
    }()
    
    var _imageViewHeightConstraint:NSLayoutConstraint?
    var imageViewHeightConstraint:NSLayoutConstraint{
        get{
            if _imageViewHeightConstraint != nil{
                self.coverImageView.removeConstraint(_imageViewHeightConstraint!)
                
            }
            
            self._imageViewHeightConstraint = NSLayoutConstraint.init(item: self.coverImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
            self._imageViewHeightConstraint!.priority = 999
            self.coverImageView.addConstraint(_imageViewHeightConstraint!)
            return _imageViewHeightConstraint!
        }
        set{
            self._imageViewHeightConstraint = newValue
        }
    }
    
    
    
    var alphaLayerForCoverImage:UIView = {
        
        let view = UIView()
        view.backgroundColor = Themes.storyDetailCells.storyDetailHeaderImageElementCell.alphaLayerForCoverImageColor.withAlphaComponent(Themes.storyDetailCells.storyDetailHeaderImageElementCell.opacityAlphaLayerForCoverImage)
        return view
        
    }()
    
    var bottomStoryTextDescription:UILabel = {
        
        let label = UILabel()
        label.textColor = Themes.storyDetailCells.storyDetailHeaderImageElementCell.bottomStoryDescriptionFontColor
        label.font = Themes.storyDetailCells.storyDetailHeaderImageElementCell.bottomStoryTextDescriptionFont
        label.clipsToBounds = true
        label.numberOfLines = 4
        label.lineBreakMode = .byWordWrapping
        return label
        
        
    }()
    
    let imageBaseUrl = "http://" + (Quintype.publisherConfig?.cdn_image)! + "/"
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? Story
        
        if let image = card?.hero_image_s3_key{
            
            let imageSize = self.calculateImageSize(metadata: card?.hero_image_metadata)
            
            self.imageViewHeightConstraint.constant = imageSize.height
            
            coverImageView.loadImage(url: imageBaseUrl + image + "?w=\(imageSize.width)", targetSize: CGSize(width: imageSize.width, height: imageSize.height),imageMetaData:(card?.hero_image_metadata))
            
        }
        
        if let storyDescription = card?.hero_image_caption{
            bottomStoryTextDescription.text = storyDescription.trim()
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
        super.setupViews()
        
        let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(coverImageView)
        coverImageView.addSubview(alphaLayerForCoverImage)
        alphaLayerForCoverImage.addSubview(bottomStoryTextDescription)
        
        view.bringSubview(toFront: alphaLayerForCoverImage)
        
        coverImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        alphaLayerForCoverImage.anchor(nil, left: coverImageView.leftAnchor, bottom: coverImageView.bottomAnchor, right: coverImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        bottomStoryTextDescription.anchor(alphaLayerForCoverImage.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        
        
    }
    
}
