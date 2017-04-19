//
//  StoryDetailTextElement.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailTextElementCell: BaseCollectionCell {
    
    
    var textElement:UITextView = {
        let textView = UITextView()
        textView.textContainerInset = Themes.storyDetailCells.storyDetailTextElementCell.cellPadding
        textView.font = Themes.storyDetailCells.storyDetailTextElementCell.TextElementFont
        textView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        return textView
        
    }()
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let html =  card?.text{
            
            textElement.convert(toHtml: html, textOption: textOption.html)
            
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(textElement)
        textElement.textColor = .red
        textElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: -5, widthConstant: 0, heightConstant: 0)
        
    }
    
}
