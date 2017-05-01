//
//  StoryDetailSummeryElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/6/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailSummeryElementCell:BaseCollectionCell {
    
    
    let summertLabel:UILabel = {
        
        let label = UILabel()
        label.text = "SUMMERY"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
        
    }()
    
    let minimizeButton:UIButton = {
        
        let button = UIButton()
//        button.setImage(UIImage(named:"arrowup"), for: UIControlState.normal)
//        button.setImage(UIImage(named:"arrowdown"), for: UIControlState.highlighted)
        button.isSelected = false
        button.imageView?.contentMode = .scaleAspectFill
        return button
        
    }()
    
    let summeryDescription:UITextView = {
        
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 15 , left: 15, bottom: 15, right: 15)
        textView.backgroundColor = UIColor.lightGray
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        return textView
        
    }()
    
    var summeryTextViewHeight:NSLayoutConstraint?
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        
        let card = data as? CardStoryElement
        
        if let summary = card?.text{
        
        summeryDescription.convert(toHtml: summary, textOption: .html)
        
        }
        
        
    }
    
    override func setupViews() {
        super.setupViews()
        
    
         let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        
        view.addSubview(summertLabel)
        view.addSubview(minimizeButton)
        view.addSubview(summeryDescription)
        
        summertLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 15, rightConstant: 0, widthConstant: 100, heightConstant: 48)
        
        

        minimizeButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 30, heightConstant: 30)

       summeryDescription.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 68, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
    }
    
    
    
    
}
