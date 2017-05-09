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
        
        button.backgroundColor = ThemeService.shared.theme.commentBackgroundCollor
        button.setTitle("Comments", for: UIControlState.normal)
        button.setTitleColor(ThemeService.shared.theme.sectionTitleColor, for: .normal)
        
        button.titleLabel?.font = ThemeService.shared.theme.sectionTitleFont
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        button.layer.cornerRadius = 5
        button.layer.borderColor = ThemeService.shared.theme.sectionTitleColor.cgColor
        button.layer.borderWidth = 1.0
        
        return button
    }()
    
    var commentArrowImage:UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named:"arrowright")
        imageView.tintColor = ThemeService.shared.theme.sectionTitleColor
        return imageView
        
    }()
    
    override func setupViews() {
        ThemeService.shared.addThemeable(themable: self)
        
        let view = self.contentView
        
        view.addSubview(commentButton)
        commentButton.addSubview(commentArrowImage)
        
        commentButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 35)
        
        commentArrowImage.anchor(commentButton.topAnchor, left: nil, bottom: nil, right: commentButton.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 5, rightConstant: 20, widthConstant: 20, heightConstant: 20)
    }
    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
    }
}


extension StoryDetailCommentElementCell:Themeable{
    func applyTheme(theme: Theme) {
        commentButton.backgroundColor = theme.commentBackgroundCollor
        commentButton.titleLabel?.textColor = theme.sectionTitleColor
        
        commentArrowImage.tintColor = ThemeService.shared.theme.sectionTitleColor
    }
}
