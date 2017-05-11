//
//  UILabelExtension.swift
//  CoreApp-iOS
//
//  Created by Albin CR on 2/20/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class InsetLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    var insets: UIEdgeInsets {
        get {
            return UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += leftInset + rightInset
        adjSize.height += topInset + bottomInset
        
        return adjSize
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftInset + rightInset
        contentSize.height += topInset + bottomInset
        
        return contentSize
    }
}

extension UILabel{
    func setLineSpacing(spacing:CGFloat){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        
        let attrString = NSMutableAttributedString(string: self.text ?? "")
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
        
    }
//    
//    func setLineHeight(lineHeight: CGFloat, labelWidth: CGFloat) -> CGFloat {
//        
//        let text = self.text
//        
//        if let unwrappedText = text {
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = lineHeight
//            
//            let attributeString = NSMutableAttributedString(string: unwrappedText)
//            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attributeString.length))
//            
//            return self.sizeThatFits(CGSize(width: labelWidth, height: 20)).height
//        }
//        
//        return 0
//    }
//    
    func heightForView(text:String, font:UIFont, width:CGFloat,lineHeight:CGFloat? = 0) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        
       label.setLineSpacing(spacing: lineHeight!)
        
        label.sizeToFit()
        return label.frame.height
    }
}
