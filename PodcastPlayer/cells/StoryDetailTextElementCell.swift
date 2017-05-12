//
//  StoryDetailTextElement.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype
import DTCoreText
import DTFoundation

class StoryDetailTextElementCell: BaseCollectionCell {
    
    var textElement:UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.font = ThemeService.shared.theme.storyHtmlTextFont
        textView.textColor = ThemeService.shared.theme.storyHtmlTextColor
        textView.linkTextAttributes = [ NSForegroundColorAttributeName: ThemeService.shared.theme.storyHtmlHyperLinkTextColor ]
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
        
        ThemeService.shared.addThemeable(themable: self)
        
        let view = self.contentView
        
        view.addSubview(textElement)

        textElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
    }
  
    deinit {
        ThemeService.shared.removeThemeable(themable: self)
    }
}

extension StoryDetailTextElementCell:Themeable{
    func applyTheme(theme: Theme) {
    
            textElement.font = theme.storyHtmlTextFont
            textElement.textColor = theme.storyHtmlTextColor
            textElement.linkTextAttributes = [ NSForegroundColorAttributeName: theme.storyHtmlHyperLinkTextColor ]
    }
}
