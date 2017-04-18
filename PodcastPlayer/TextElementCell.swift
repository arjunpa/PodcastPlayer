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
    
    static let kmarginPadding:CGFloat = 16
    
    var textView: UITextView = {
       let view = UITextView()
        view.isEditable = false
        view.isScrollEnabled = true
        view.dataDetectorTypes = .link
        view.textContainerInset = UIEdgeInsets.zero
        return view
    }()
    
    
    override func setupView() {
        let view = self.contentView
        view.addSubview(textView)
        
        textView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: TextElementCell.kmarginPadding, leftConstant: TextElementCell.kmarginPadding, bottomConstant: TextElementCell.kmarginPadding, rightConstant: TextElementCell.kmarginPadding, widthConstant: 0, heightConstant: 0)

    }
    
    
    override func configure(data: Any?) {
        let card = data as? CardStoryElement
        
        if let html =  card?.text{
            textView.convert(toHtml: html, textOption: textOption.html)
        }
    }
    
    class func calcHeight(data:Any?, targetSize:CGSize) -> CGSize{
        let textViewd = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: targetSize.width - 2 * kmarginPadding, height: 2))
        textViewd.textContainerInset = UIEdgeInsets.zero
        let card = data as? CardStoryElement
        
        if let html =  card?.text{
            textViewd.convert(toHtml: html, textOption: textOption.html)
        }
//        let rect = textViewd.layoutManager.usedRect(for: textViewd.textContainer)
//        print("\(rect)   contentsize: \(textViewd.contentSize)")
//        let sizeAttr = textViewd.attributedText.boundingRect(with: CGSize.init(width: targetSize.width - 2 * kmarginPadding, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        
        let height = textViewd.setLineHeight(lineHeight: 1.2, labelWidth: targetSize.width - 2 * kmarginPadding)
        return CGSize.init(width: targetSize.width, height:ceil(height) + 2 * kmarginPadding)
    }
    
    

}

extension UITextView{
    
    func setLineHeight(lineHeight: CGFloat, labelWidth: CGFloat) -> CGFloat {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(attributedString: self.attributedText)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, text.characters.count))
            
            return self.sizeThatFits(CGSize(width: labelWidth, height: 20)).height
        }
        return 0
    }
    
}
