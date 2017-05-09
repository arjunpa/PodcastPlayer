//
//  StoryDetailAuthorElemenCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailAuthorElemenCell: BaseCollectionCell {
    
    
    let authorImage:UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .lightGray
        return imageView
        
    }()
    
    let authorName:UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor.red
        return label
        
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(authorImage)
        view.addSubview(authorName)
        
        authorImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 15, rightConstant: 0, widthConstant: 60, heightConstant: 60)
        
        authorName.anchor(authorImage.topAnchor, left: authorImage.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 25, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        
        let story = data as? Story
        
        if let author = story?.author_name{
            authorName.text = author
        }
//        if let authorImageLink = 
//        authorImage.loadImage(url: , targetSize: CGSize(width: authorImage.frame.width, height: authorImage.frame.height))
//        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
