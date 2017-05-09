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
    
    let imageBaseUrl = "https://" + (Quintype.publisherConfig?.cdn_image)! + "/"
    
    var coverImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var bottomTitleTextLabel : InsetLabel = {
        let textLabel = InsetLabel()
        textLabel.insets = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        textLabel.layer.cornerRadius = 3
        textLabel.layer.borderColor = UIColor.black.cgColor
        textLabel.layer.borderWidth = 1.0
        textLabel.numberOfLines = 1
        
        return textLabel
        
    }()
    
    let shareButton:UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named:"share"), for: UIControlState.normal)
        button.imageView?.image = button.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        button.imageView?.tintColor = ThemeService.shared.theme.sectionTitleColor
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
        
    }()
    
    var currentTheam:Theme!
    
    override func setupViews() {
        
        let view = self.contentView
        
        ThemeService.shared.addThemeable(themable: self,applyImmediately: true)
        
        view.addSubview(coverImageView)
        view.addSubview(bottomTitleTextLabel)
        view.addSubview(shareButton)
        
        coverImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 250)
        
        bottomTitleTextLabel.anchor(coverImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        shareButton.anchor(bottomTitleTextLabel.topAnchor, left: nil, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: -8, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 40, heightConstant: 40)
        
        let spacingConstraint =  NSLayoutConstraint.init(item: bottomTitleTextLabel, attribute: .right, relatedBy: .lessThanOrEqual, toItem: shareButton, attribute: .left, multiplier: 1, constant: -15)
        
        view.addConstraint(spacingConstraint)
        
        
    }
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? Story
        
        if let image = card?.hero_image_s3_key{
            
            let imageSize = self.calculateImageSize(metadata: card?.hero_image_metadata)
            
            coverImageView.loadImage(url: imageBaseUrl + image + "?w=\(imageSize.width)", targetSize: CGSize(width: imageSize.width, height: 250),imageMetaData:(card?.hero_image_metadata))
        }
        
        bottomTitleTextLabel.text = card?.sections.first?.display_name ?? card?.sections.first?.name
        
        bottomTitleTextLabel.addTextSpacing(spacing: 1.7)
        
    }
    
    func calculateImageSize(metadata:ImageMetaData?) -> CGSize{
        let screenWidth = UIScreen.main.bounds.size.width
        guard metadata != nil else {
            return CGSize.init(width: screenWidth, height: screenWidth * 3.0/4.0)
        }
        
        if let width = metadata?.width, metadata!.height != nil{
            let imageWidth = CGFloat(width.floatValue)
            let imageHeight = CGFloat((metadata?.height!.floatValue)!)
            
            let actualImageHeight = screenWidth * imageHeight/imageWidth //aspect ratio
            return CGSize.init(width: screenWidth, height: actualImageHeight)
        }
        return CGSize.init(width: screenWidth, height: screenWidth * 3.0/4.0)
    }
    
    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
    }
}

extension StoryDetailHeaderImageElementCell:Themeable{
    func applyTheme(theme: Theme) {
        if currentTheam == nil || type(of:theme) != type(of:currentTheam!){
            self.currentTheam = theme
            
            bottomTitleTextLabel.font = theme.sectionTitleFont
            bottomTitleTextLabel.textColor = theme.sectionTitleColor
            bottomTitleTextLabel.layer.borderColor = theme.sectionTitleColor.cgColor
            
            shareButton.imageView?.tintColor = theme.sectionTitleColor
        }
    }
}







