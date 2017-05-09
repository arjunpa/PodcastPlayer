//
//  StoryDetailQandACell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/8/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailQandACell: BaseCollectionCell {
    
    
    var QuestionTextView : UITextView = {
        let tv = UITextView()
        tv.textContainerInset = UIEdgeInsets.zero
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = ThemeService.shared.theme.questionElementFont
        tv.textColor = ThemeService.shared.theme.questionElementColor
        return tv
    }()
    
    var AnswerTextView : UITextView = {
        let tv = UITextView()
        tv.textContainerInset = UIEdgeInsets.zero
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.font = ThemeService.shared.theme.answerElementFont
        tv.textColor = ThemeService.shared.theme.answerElementColor
        return tv
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        ThemeService.shared.addThemeable(themable: self)
        
        let view = self.contentView
        view.addSubview(QuestionTextView)
        view.addSubview(AnswerTextView)
        
        QuestionTextView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        AnswerTextView.anchor(QuestionTextView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
    }
    
    override func configure(data: Any?) {
        let card = data as? CardStoryElement
        
        QuestionTextView.convert(toHtml: card?.metadata?.question ?? "", textOption: textOption.question)
        AnswerTextView.convert(toHtml: card?.metadata?.answer ?? "", textOption: textOption.answer)
    }
    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
    }
}

extension StoryDetailQandACell : Themeable{
    func applyTheme(theme: Theme) {
        QuestionTextView.font = theme.questionElementFont
        QuestionTextView.textColor = theme.questionElementColor
        
        AnswerTextView.font = theme.answerElementFont
        AnswerTextView.textColor = theme.answerElementColor
        
    }
}
