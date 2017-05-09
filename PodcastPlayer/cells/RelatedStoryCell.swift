//
//  RelatedStoryCell.swift
//  CoreApp-iOS
//
//  Created by Albin CR on 3/15/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class RelatedStoryCell: BaseCollectionCell {
    
    var newsImage:UIImageView = {
        
        let imageView = UIImageView()
        return imageView
        
    }()
    
    var newsHeadline:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 3
        label.font = Themes.relatedView.titleFont
        label.textColor = Themes.relatedView.titleFontColor
        label.lineBreakMode = .byWordWrapping
        return label
        
    }()
    
    var date:UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "20-19-2993"
        label.font = Themes.relatedView.timeFont
        label.textColor = Themes.relatedView.timeFontColor
        label.lineBreakMode = .byWordWrapping
        return label
        
    }()

    func calculateImageSize(metadata:ImageMetaData?) -> CGSize{
        
        let widthDimension2 = UIScreen.main.bounds.size.width
        return CGSize.init(width: widthDimension2, height: widthDimension2 * 3.0/4.0)
    }
    
     func load(_ view: UIView) {

        // Round the banner's corners
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: ([.allCorners]), cornerRadii: CGSize(width: CGFloat(10), height: CGFloat(10)))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
        // Round cell corners
        self.layer.cornerRadius = 0
        // Add shadow
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 10.0
        self.layer.shouldRasterize = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    override func setupViews() {
        super.setupViews()
        
        let view = contentView
        
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 2.0
        view.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        view.backgroundColor = Themes.relatedView.cellbackgroundColor
        view.addSubview(newsImage)
        view.addSubview(newsHeadline)
        view.addSubview(date)
        
        newsImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        
        newsHeadline.anchor(view.topAnchor, left: newsImage.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        date.anchor(newsHeadline.bottomAnchor, left: newsImage.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
    }
    
    
    override func configure(data: Any?) {
        let story = data as? Story
        newsHeadline.text = story?.headline?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        
        
    }
    
    
}
