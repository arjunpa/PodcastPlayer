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
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isScrollEnabled = true
        
        textView.textColor = ThemeService.shared.theme.questionElementColor
        textView.font = ThemeService.shared.theme.questionElementFont
        return textView
        
    }()
    
    
    
    override func setupViews() {
        
        ThemeService.shared.addThemeable(themable: self)
        
         let view = self.contentView
        
        view.addSubview(questionTextElement)
        questionTextElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let questionText = card?.text{
            questionTextElement.convert(toHtml: questionText, textOption: textOption.question)
        }
    }
    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
    }
    
}



extension StoryDetailQuestionElementCell:Themeable{
    func applyTheme(theme: Theme) {
        questionTextElement.textColor = ThemeService.shared.theme.questionElementColor
        questionTextElement.font = ThemeService.shared.theme.questionElementFont
    }
}
