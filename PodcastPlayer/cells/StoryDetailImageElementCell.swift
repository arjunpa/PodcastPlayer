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
    
    let imageTextDescription:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 4
        label.lineBreakMode = .byWordWrapping
        label.font = ThemeService.shared.theme.imageCaptionFont
        label.textColor = ThemeService.shared.theme.imageCaptionTextColor
        return label
        
    }()
    
    var currentTheam : Theme!
    
    var _imageViewHeightConstraint:NSLayoutConstraint?
    var imageViewHeightConstraint:NSLayoutConstraint{
        get{
            if _imageViewHeightConstraint != nil{
                return _imageViewHeightConstraint!
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
    
    override func setupViews() {
        
        let view = self.contentView
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(imageTextDescription)
        
        ThemeService.shared.addThemeable(themable: self)
        
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant:screenWidth , heightConstant: 0)
        
        imageTextDescription.anchor(imageView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: 15, bottomConstant: 8, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        // image tap configured in StoryPager
        
    }
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        if let card = data as? CardStoryElement{
            
            if let image =  card.image_s3_key{
                
                let imageSize = self.calculateImageSize(metadata: card.hero_image_metadata)
                
                self.imageViewHeightConstraint.constant = imageSize.height
                
                imageView.loadImage(url: imageBaseUrl + image + "?w=\(imageSize.width)", targetSize: CGSize(width: imageSize.width, height: imageSize.height),imageMetaData:(card.hero_image_metadata))
                
                if let imageDescription = card.title{
                    imageView.accessibilityLabel = imageBaseUrl + image
                    imageTextDescription.text = imageDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                }
            }
        }else if let meta = data as? MetaImage{
            self.contentView.backgroundColor = UIColor(hexString:"#f9f9f9")
//            let imageSize = self.calculateImageSize(metadata: meta.imageMeta)
            
            self.imageViewHeightConstraint.constant = self.contentView.bounds.height
            
            imageView.loadImage(url: imageBaseUrl + (meta.image ?? "") + "?w=\(self.contentView.bounds.width)", targetSize:  CGSize(width: self.contentView.bounds.width, height: self.contentView.bounds.height), imageMetaData: meta.imageMeta)
            
            if let imageDescription = meta.imageDescription{
                imageView.accessibilityLabel = imageBaseUrl + (meta.image ?? "")
//                imageTextDescription.text = imageDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                imageTextDescription.text = nil
            }
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
    
    deinit {
        ThemeService.shared.removeThemeable(themable: self)
    }
}

extension StoryDetailImageElementCell:Themeable{
    func applyTheme(theme: Theme) {
        currentTheam = theme
        imageTextDescription.font = theme.imageCaptionFont
        imageTextDescription.textColor = theme.imageCaptionTextColor
    }
}
