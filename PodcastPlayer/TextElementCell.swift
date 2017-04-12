//
//  TextElementCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/11/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

class TextElementCell: BaseCollectionCell {
    
    let kmarginPadding:CGFloat = 16
    
    var textView: UITextView = {
       let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = true
     //   view.dataDetectorTypes = .link
        return view
    }()
    
    
    override func setupView() {
        let view = self.contentView
        view.addSubview(textView)
        
        textView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: kmarginPadding, leftConstant: kmarginPadding, bottomConstant: kmarginPadding, rightConstant: kmarginPadding, widthConstant: 0, heightConstant: 0)

    }
    
    
    override func configure(data: Any?) {
        let card = data as? CardStoryElement
        
        if let html =  card?.text{
            textView.convert(toHtml: html, textOption: textOption.html)
        }
        
        
    }
    
    override func caculateSize(targetSize: CGSize) -> CGSize {
        
        
        return CGSize.init(width: targetSize.width, height: 200)
    }
}
