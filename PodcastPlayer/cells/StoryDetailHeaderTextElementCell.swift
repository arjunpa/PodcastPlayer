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
        label.textColor = Themes.storyDetailCells.storyDetailHeaderTextElementCell.headerFontColor
        label.font =  Themes.storyDetailCells.storyDetailHeaderTextElementCell.headerFontSize
        label.numberOfLines = 0
        return label
        
    }()
    
    //    var shortDescription:UILabel = {
    //
    //        let label = UILabel()
    //        label.textColor = Themes.storyDetailCells.StoryHeaderDetailCell.shortDescriptionFontColor
    //        label.font = .systemFont(ofSize: Themes.storyDetailCells.StoryHeaderDetailCell.shortDescriptionFontSize)
    //        label.numberOfLines = 0
    //        label.textAlignment = .left
    //        return label
    //
    //    }()
    //
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let data = data as? Story
        
        if let heading = data?.headline{
            headingText.text = heading
        }
        
        //        if let description = data
        
        
    }
    
    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        view.addSubview(headingText)
        //        self.contentView.addSubview(shortDescription)
    
        headingText.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 8, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        //        shortDescription.anchor(headingText.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
    }
    
}
