//
//  StoryDetailblockkQuoteCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailBlockkQuoteElementCell: BaseCollectionCell {
    
    
    
    var textElement:UITextView = {
        
        let textView = UITextView()
        textView.textContainerInset = Themes.storyDetailCells.storyDetailBlockkQuoteElementCell.blockkQuoteTextPadding
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.font = Themes.storyDetailCells.storyDetailBlockkQuoteElementCell.blockblockkQuoteFont
        textView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        return textView
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(textElement)
        
        textElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
    }
    
    override func layoutSubviews() {
        
        let leftBorder = CALayer()
        leftBorder.backgroundColor = Themes.storyDetailCells.storyDetailBlockkQuoteElementCell.blockkQuoteBarColor
        textElement.setNeedsLayout()
        textElement.layoutIfNeeded()
        leftBorder.frame = CGRect(x: 0, y: 0, width: Themes.storyDetailCells.storyDetailBlockkQuoteElementCell.blockkQuoteBarWidth, height: (textElement.bounds.height))
        textElement.layer.addSublayer(leftBorder)
        
    }
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let blockkQuoteText = card?.metadata?.content{
            textElement.convert(toHtml: blockkQuoteText, textOption: textOption.html)
        }
        
        
        
    }
    
}
