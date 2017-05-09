//
//  StoryDetailBlurbElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype
import DTCoreText
import DTFoundation

class StoryDetailBlurbElementCell: BaseCollectionCell {
    
    var textElement:UITextView = {
        
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets.zero
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = .link
        textView.textAlignment = .center
        
        textView.font = ThemeService.shared.theme.blurbElementFont
        textView.textColor = ThemeService.shared.theme.blurbElementColor
        
        return textView
        
    }()
    
    var topLineView : UIView = {
        let view = UIView()
        view.backgroundColor = ThemeService.shared.theme.quoteAttributtionColor
        return view
    }()
    
    var bottomLineView : UIView = {
        let view = UIView()
        view.backgroundColor = ThemeService.shared.theme.quoteAttributtionColor
        return view
    }()
    
    
    override func setupViews() {
        
        let view = self.contentView
        
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(textElement)
        view.addSubview(topLineView)
        view.addSubview(bottomLineView)
        
        topLineView.anchor(view.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width/3, heightConstant: 1)
        
        textElement.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        bottomLineView.anchor(nil, left: nil, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: UIScreen.main.bounds.width/3, heightConstant: 1)
        
        topLineView.anchorCenterXToSuperview()
        bottomLineView.anchorCenterXToSuperview()
    }
    
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        
        if let blurbText = card?.metadata?.content{
            textElement.convert(toHtml: blurbText, textOption: textOption.blurb)
            textElement.textAlignment = .justified
        }
        
    }

    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
    }
}

extension StoryDetailBlurbElementCell:Themeable{
    func applyTheme(theme: Theme) {
        textElement.font = theme.blurbElementFont
        textElement.textColor = theme.blurbElementColor
        
        topLineView.backgroundColor = theme.quoteAttributtionColor
        bottomLineView.backgroundColor = theme.quoteAttributtionColor
    }
}
