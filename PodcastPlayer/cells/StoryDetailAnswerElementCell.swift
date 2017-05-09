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
        
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.dataDetectorTypes = .link
        textView.font = ThemeService.shared.theme.answerElementFont
        textView.textColor = ThemeService.shared.theme.answerElementColor
        return textView
        
    }()
    
    
    override func setupViews() {
        let view = self.contentView
        
        ThemeService.shared.addThemeable(themable: self)
        
        view.addSubview(answerTextElement)
        
        answerTextElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let answerText = card?.text{
            answerTextElement.convert(toHtml: answerText, textOption: textOption.answer)
        }
    }
    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
        
    }
}

extension StoryDetailAnswerElementCell:Themeable{
    func applyTheme(theme: Theme) {
        answerTextElement.textColor = ThemeService.shared.theme.answerElementColor
        answerTextElement.font = ThemeService.shared.theme.answerElementFont
    }
}
