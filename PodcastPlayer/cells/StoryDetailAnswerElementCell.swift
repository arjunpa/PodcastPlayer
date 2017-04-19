//
//  StoryDetailAnswerElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/7/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailAnswerElementCell: BaseCollectionCell {
    
 
    var answerTextElement:UITextView = {
        
        let textView = UITextView()
        textView.textContainerInset = Themes.storyDetailCells.storyDetailQnAElementCell.answerPadding
        textView.textColor = Themes.storyDetailCells.storyDetailQnAElementCell.answerFontColor
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.font = Themes.storyDetailCells.storyDetailQnAElementCell.answerFontSize
        textView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        return textView
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
       
        view.addSubview(answerTextElement)
        
        answerTextElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement

        if let answerText = card?.text{
            answerTextElement.convert(toHtml: answerText, textOption: textOption.html)
        }
        
        
        
        
        
    }
}
