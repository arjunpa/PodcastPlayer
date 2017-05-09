//
//  StoryHeaderDetailCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailHeaderTextElementCell: BaseCollectionCell {
    
    
    
    var headingText:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        return label
        
    }()
    
    var subtitleLabel:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
        
    var currentTheam : Theme!
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let data = data as? Story
        
        if let heading = data?.headline{
            headingText.text = heading
        }
        subtitleLabel.text = data?.subheadline ?? ""
        
        headingText.setLineSpacing(spacing: 1.56)
        subtitleLabel.setLineSpacing(spacing: 1.69)
    }
    
    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
        
        ThemeService.shared.addThemeable(themable: self,applyImmediately: true)
        
        view.addSubview(headingText)
        view.addSubview(subtitleLabel)
    
        headingText.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        subtitleLabel.anchor(headingText.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 10, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
    }
    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
    }
}

extension StoryDetailHeaderTextElementCell:Themeable{
    func applyTheme(theme: Theme) {
        if currentTheam == nil || type(of:theme) != type(of:currentTheam!){
        headingText.textColor = theme.storyHeadlineColor
        headingText.font = theme.storyHeadlineFont
        
        subtitleLabel.textColor = theme.storySubheadlineColor
        subtitleLabel.font = theme.storySubheadlineFont
        }
    }
}
