//
//  StoryDetailTitleElementCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/15/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailTitleElementCell: BaseCollectionCell {
    
    var headingText:UILabel = {
        
        let label = UILabel()
        label.textColor = Themes.storyDetailCells.storyDetailTitleElementCell.headerFontColor
        label.font =  Themes.storyDetailCells.storyDetailTitleElementCell.headerFontSize
        label.numberOfLines = 0
        return label
        
    }()
    
    override func setupViews() {
        super.setupViews()
        
        let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        view.addSubview(headingText)
        //        self.contentView.addSubview(shortDescription)
        
        headingText.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 8, rightConstant: 15, widthConstant: 0, heightConstant: 0)
    }
    
    override func configure(data: Any?) {
        super.configure(data: data)
        let card = data as? CardStoryElement
        
        headingText.text = card?.text
    }
}

