//
//  StoryDetailQuestionElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/7/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailQuestionElementCell: BaseCollectionCell {
    
    
    let questionTextElement:UITextView = {
    
        let textView = UITextView()
        textView.textColor = Themes.storyDetailCells.storyDetailQnAElementCell.questionFontColor
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.font = Themes.storyDetailCells.storyDetailQnAElementCell.questionFontSize
        textView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        textView.textColor = .blue
        return textView
        
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        
        view.addSubview(questionTextElement)
        questionTextElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let questionText = card?.text{
            questionTextElement.convert(toHtml: questionText, textOption: textOption.html)
        }
    }
    
}
