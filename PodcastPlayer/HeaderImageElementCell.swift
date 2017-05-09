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
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    let kinterElementSpacing:CGFloat = 15
    let kmarginPadding:CGFloat = 16
    
    let imageBaseUrl = "https://" + (Quintype.publisherConfig?.cdn_image)! + "/"
    
    
    var imageView : UIImageView = {
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
    
    var bottomDescriptionTextLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        return textLabel
        
    }()
    
    var currentTheam : Theme!
    
    override func setupViews() {
        super.setupViews()
        
        //added for themeing
        ThemeService.shared.addThemeable(themable: self,applyImmediately: true)
        
        let view = self.contentView
        view.addSubview(imageView)
        view.addSubview(bottomTitleTextLabel)
        view.addSubview(bottomDescriptionTextLabel)
        
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 220)
        
        bottomTitleTextLabel.anchor(imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: kinterElementSpacing, leftConstant: kmarginPadding, bottomConstant: 0, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
        
        bottomDescriptionTextLabel.anchor(bottomTitleTextLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 8, leftConstant: kmarginPadding, bottomConstant: 10, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)
        
        let spacingConstraint =  NSLayoutConstraint.init(item: bottomTitleTextLabel, attribute: .right, relatedBy: .lessThanOrEqual, toItem: view, attribute: .right, multiplier: 1, constant: -15)
        
        view.addConstraint(spacingConstraint)
    }
    
    override func configure(data:Any?){
        let story = data as? Story
        self.imageView.image = nil
        bottomTitleTextLabel.text = story?.sections.first?.display_name ?? story?.sections.first?.name ?? ""
        
        bottomTitleTextLabel.addTextSpacing(spacing: 1.7)
        
        bottomDescriptionTextLabel.text = story?.headline
        bottomDescriptionTextLabel.setLineSpacing(spacing: 2)
        
        if let image = story?.hero_image_s3_key{
            let imageSize = calculateImageSize(metadata: story?.hero_image_metadata,width: screenWidth)
            
            self.imageView.loadImage(url: self.imageBaseUrl + image + "?w=\(imageSize.width)", targetSize: imageSize, imageMetaData: (story?.hero_image_metadata))
        }
    }

    deinit{
        ThemeService.shared.removeThemeable(themable: self)
        print("HeaderImageElementCell denit called")
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



extension HeaderImageElementCell : Themeable{
    func applyTheme(theme: Theme) {
        
        if currentTheam == nil || type(of:theme) != type(of:currentTheam!){
            self.currentTheam = theme
            
            bottomTitleTextLabel.font = theme.sectionTitleFont
            bottomTitleTextLabel.textColor = theme.sectionTitleColor
            bottomTitleTextLabel.layer.borderColor = theme.sectionTitleColor.cgColor
            
            bottomDescriptionTextLabel.font = theme.headerTitleFont
            bottomDescriptionTextLabel.textColor = theme.headerTitleColor
        }
    }
}
