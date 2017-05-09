//
//  StoryDetailBigFactElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import UIKit
import Quintype

class StoryDetailBigFactElementCell:BaseCollectionCell{
    
    
    
    let bigFactTitleElement:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Themes.storyDetailCells.storyDetailBigFactElementCell.bigFactTitleFontColor
        label.text = "BigFact"
        label.font =  Themes.storyDetailCells.storyDetailBigFactElementCell.bigFactTitleFontSize
        return label
        
    }()
   
    var bigFactTextElement:UITextView = {
        
        let textView = UITextView()
        textView.textContainerInset = Themes.storyDetailCells.storyDetailBigFactElementCell.bigFactTextPadding
        textView.textColor = Themes.storyDetailCells.storyDetailBigFactElementCell.bigFactFontColor
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.font = Themes.storyDetailCells.storyDetailBigFactElementCell.bigFactFontSize
        textView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        return textView
        
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(bigFactTitleElement)
        view.addSubview(bigFactTextElement)
        
        bigFactTitleElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        bigFactTextElement.anchor(bigFactTitleElement.bottomAnchor, left: bigFactTitleElement.leftAnchor, bottom: view.bottomAnchor, right: bigFactTitleElement.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        
    }
    
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card =  data as? CardStoryElement
        
        if let bigFactText = card?.metadata?.attribution{
            
            bigFactTextElement.text = bigFactText
            
        }
        
        if let bigFactTitle = card?.metadata?.content{
            
            bigFactTitleElement.text = bigFactTitle
            
        }
        
        
        
        
        
    }
    
}
