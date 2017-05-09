//
//  StoryDetailQuoteElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype
import DTCoreText

class StoryDetailQuoteElementCell: BaseCollectionCell {
    
    
    var quoteImage:UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Themes.storyDetailCells.storyDetailQuoteElementCell.quoteImage
        imageView.tintColor = Themes.storyDetailCells.storyDetailQuoteElementCell.quoteIconColor
        return imageView
    }()
    
    var textElement:UITextView = {
        
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        
        textView.font = ThemeService.shared.theme.storyHtmlTextFont
        textView.textColor = ThemeService.shared.theme.storyHtmlTextColor
        textView.linkTextAttributes = [ NSForegroundColorAttributeName: ThemeService.shared.theme.storyHtmlHyperLinkTextColor ]
        
        return textView
        
    }()
    
    let authorName:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = ThemeService.shared.theme.normalListSectionFont
        label.textColor = ThemeService.shared.theme.quoteAttributtionColor
        return label
        
    }()
    
    var quotelineView :UIView = {
        let view = UIView()
        view.backgroundColor = ThemeService.shared.theme.quoteAttributtionColor
        
        return view
    }()
    
    var currentTheam: Theme!
    var themeApplyed = false
    
    override func setupViews() {
        
        let view = self.contentView
        
        ThemeService.shared.addThemeable(themable: self)
        
        
        view.addSubview(quoteImage)
        view.addSubview(textElement)
        view.addSubview(authorName)
        view.addSubview(quotelineView)
        
        quoteImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        textElement.anchor(view.topAnchor, left: quoteImage.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 5, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        authorName.anchor(textElement.bottomAnchor, left: quoteImage.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        quotelineView.anchor(quoteImage.bottomAnchor, left: view.leftAnchor, bottom: authorName.bottomAnchor, right: nil, topConstant: 5, leftConstant: 30, bottomConstant: 0, rightConstant: 0, widthConstant: 2, heightConstant: 0)
        
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let quoteText = card?.metadata?.content?.trim(){
            textElement.convert(toHtml: quoteText, textOption: textOption.quote)

            authorName.text = card?.metadata?.attribution?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        }
    }
    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
    }
}

extension StoryDetailQuoteElementCell:Themeable{
    func applyTheme(theme: Theme) {
        
        textElement.font = theme.storyHtmlTextFont
        textElement.textColor = theme.storyHtmlTextColor
        textElement.linkTextAttributes = [ NSForegroundColorAttributeName: theme.storyHtmlHyperLinkTextColor ]
        
        authorName.font = theme.normalListSectionFont
        authorName.textColor = theme.quoteAttributtionColor
        
        quotelineView.backgroundColor = theme.quoteAttributtionColor
        
    }
}

