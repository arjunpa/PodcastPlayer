//
//  StoryDetailBlurbElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailBlurbElementCell: BaseCollectionCell {
    
    var textElement:UITextView = {
        
        let textView = UITextView()
        textView.textContainerInset = Themes.storyDetailCells.storyDetailBlurbElementCell.blurbTextpadding
        textView.textColor = Themes.storyDetailCells.storyDetailBlurbElementCell.blurbFontColor
        textView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.font = Themes.storyDetailCells.storyDetailBlurbElementCell.blurbFontName
        return textView
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
        
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(textElement)
        
        textElement.fillSuperview()
        
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        
        if let blurbText = card?.metadata?.content{
            textElement.convert(toHtml: blurbText, textOption: textOption.html)
//            textElement.text = blurbText
            
        }
        
        
        
        
    }
    
}
