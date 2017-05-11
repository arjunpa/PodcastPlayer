//
//  BaseCollectionCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

protocol BaseCollectionCellDelegate:class {
    
    func didCalculateSize(indexPath:Int,size:CGSize,elementType:storyDetailLayoutType)
    
}


class BaseCollectionCell: UICollectionViewCell {
    var delegate:BaseCollectionCellDelegate?
    
    var lineView:UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString:"#e9e8e8")
        
        return view
    }()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    var hasLayouted:Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews(){
        let view = self.contentView
        view.addSubview(lineView)
        
        lineView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 1, rightConstant: 16, widthConstant: 0, heightConstant: 1)
    }
    
    func configure(data:Any?){
        
    }
    
    func configure(data:Any?,index:Int,status:Bool){
        
    }
    
    func caculateSize(targetSize : CGSize) -> CGSize{
        
        var newSize = targetSize
        newSize.width = targetSize.width
        
        let widthConstraint = NSLayoutConstraint(item: self.contentView,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant:newSize.width)
        
        contentView.addConstraint(widthConstraint)
        
        var size = UILayoutFittingCompressedSize
        size.width = newSize.width
        
        let cellSize = self.contentView.systemLayoutSizeFitting(size, withHorizontalFittingPriority: 1000, verticalFittingPriority:1)
        contentView.removeConstraint(widthConstraint)
        
        return cellSize
        
    }
    
    func calculateHeight(targetSize : CGSize) -> CGSize{
        
        var newSize = targetSize
        newSize.width = targetSize.width
        
        let widthConstraint = NSLayoutConstraint(item: self.contentView,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant:newSize.width)
        
        
        contentView.addConstraint(widthConstraint)
        
        var size = UILayoutFittingCompressedSize
        size.width = newSize.width
        
        let cellSize = self.contentView.systemLayoutSizeFitting(size, withHorizontalFittingPriority: 1000, verticalFittingPriority:1)
        contentView.removeConstraint(widthConstraint)
        
        return cellSize
        
    }
    
    func calculateTextViewHeight(data:String?, targetSize:CGSize,textOption:textOption? = textOption.html) -> (CGSize,NSAttributedString){
        var sizeAndAttributtedText :(CGSize,NSAttributedString) = (CGSize.zero,NSAttributedString(string:""))
        
        let textview = UITextView(frame: CGRect.init(x: 0, y: 0, width: targetSize.width - 2 * 16, height: 2))
        textview.isScrollEnabled = false
        
        if let html =  data{
            textview.textContainerInset = UIEdgeInsets.zero
            let _ = textview.convertAndReturn(toHtml: html, textOption: textOption!)
            
        }
        
        let height = textview.setLineHeight(lineHeight: 1.2, labelWidth: targetSize.width - 2 * 16)
        
        sizeAndAttributtedText.0 = CGSize.init(width: targetSize.width, height:ceil(height) + 2 * 16)
        textview.frame.size = sizeAndAttributtedText.0
        sizeAndAttributtedText.1 = textview.attributedText!
        return sizeAndAttributtedText
        
    }
}

extension UITextView{
    
    func setLineHeight(lineHeight: CGFloat, labelWidth: CGFloat) -> CGFloat {
        
        let text = self.text
        
        if let unwrappedText = text {
            let attributeString = NSMutableAttributedString(attributedString: self.attributedText)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, unwrappedText.characters.count))
            
            return self.sizeThatFits(CGSize(width: labelWidth, height: 20)).height
        }
        
        return 0
    }
    
}
