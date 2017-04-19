//
//  StoryDetailQuoteElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

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
        textView.textContainerInset = Themes.storyDetailCells.storyDetailQuoteElementCell.quoteTextPadding
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = Themes.storyDetailCells.storyDetailQuoteElementCell.quoteFontName
        textView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        textView.dataDetectorTypes = .link
        return textView
        
    }()
    
    let authorName:UILabel = {
        
        let label = UILabel()
        label.textColor = Themes.storyDetailCells.storyDetailQuoteElementCell.authorFontColor
        label.font = Themes.storyDetailCells.storyDetailQuoteElementCell.authorFontSize
        label.numberOfLines = 0
        return label
        
    }()
    
    
    
    override func setupViews() {
        
        super.setupViews()
        
         let view = self.contentView
view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        
        view.addSubview(quoteImage)
        view.addSubview(textElement)
        view.addSubview(authorName)
        
        quoteImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        textElement.anchor(view.topAnchor, left: quoteImage.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 25, leftConstant: 5, bottomConstant: 15, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
//        authorName.anchor(textElement.bottomAnchor, left: textElement.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 5, bottomConstant: 15, rightConstant:15, widthConstant: 0, heightConstant: 0)
//        
        
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let quoteText = card?.metadata?.content{
               textElement.convert(toHtml: quoteText, textOption: textOption.html)
        }
        
//        if let author = card?.metadata?.attribution{
//            authorName.text = "- " + author
//        }
  
    }
    
    
    
}
