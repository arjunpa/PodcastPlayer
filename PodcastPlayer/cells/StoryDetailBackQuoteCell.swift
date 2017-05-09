//
//  StoryDetailblockkQuoteCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype
import DTCoreText
import DTFoundation

class StoryDetailBlockkQuoteElementCell: BaseCollectionCell {
    
    var textElement:UITextView = {
        
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.font = ThemeService.shared.theme.blockquoteElementFont
        textView.textColor = ThemeService.shared.theme.blockQuoteElementColor
        textView.linkTextAttributes = [ NSForegroundColorAttributeName: ThemeService.shared.theme.storyHtmlHyperLinkTextColor ]
        return textView
        
    }()
    
    var currentTheam : Theme!
    var themeApplyed = false
    
    
    override func setupViews() {
        
        let view = self.contentView
        ThemeService.shared.addThemeable(themable: self)
        
        view.addSubview(textElement)
        
        textElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
    }
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let blockkQuoteText = card?.metadata?.content{
            textElement.convert(toHtml: blockkQuoteText, textOption: textOption.blockquote)
            
        }
    }

    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
    }
}

extension StoryDetailBlockkQuoteElementCell : Themeable{
    func applyTheme(theme: Theme) {
        
            textElement.font = theme.blockquoteElementFont
            textElement.textColor = theme.blockQuoteElementColor
            textElement.linkTextAttributes = [ NSForegroundColorAttributeName: theme.storyHtmlHyperLinkTextColor ]
        
    }
}
