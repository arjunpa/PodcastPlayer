//
//  StoryDetailCommentElementCell.swift
//  CoreApp-iOS
//
//  Created by Albin CR on 2/20/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import UIKit
import Quintype

class StoryDetailCommentElementCell:BaseCollectionCell{
    
    
    var commentButton:UIButton = {
       
        let button = UIButton()
        button.backgroundColor = Themes.storyDetailCells.StoryDetailCommentElementCell.commentButtonColor
        
        
        button.titleLabel?.font = Themes.storyDetailCells.StoryDetailCommentElementCell.commentFontSize
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.layer.cornerRadius = Themes.storyDetailCells.StoryDetailCommentElementCell.commntButtonRadius
        return button
    }()
    
    var commentArrowImage:UIImageView = {
       
        let imageView = UIImageView()
        imageView.image = Themes.storyDetailCells.StoryDetailCommentElementCell.commentButtonImage
        imageView.tintColor = Themes.storyDetailCells.StoryDetailCommentElementCell.commentTextColor
        return imageView
        
    }()

    override func setupViews() {
        super.setupViews()
        
        let defaults = UserDefaults.standard
    
            commentButton.setTitle("Comments", for: UIControlState.normal)
       
        
         let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(commentButton)
        commentButton.addSubview(commentArrowImage)
        
        commentButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 35)
        
        commentArrowImage.anchor(commentButton.topAnchor, left: nil, bottom: nil, right: commentButton.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 5, rightConstant: 20, widthConstant: 20, heightConstant: 20)
        
        
    }
    
    
}
