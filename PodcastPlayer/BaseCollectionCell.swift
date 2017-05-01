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
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupView()
    }
    var hasLayouted:Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        
    }
    func setupViews(){
        
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
    
    func calculateTextViewHeight(data:Any?, targetSize:CGSize) -> CGSize{
        
        let textview = UITextView(frame: CGRect.init(x: 0, y: 0, width: targetSize.width - 2 * 16, height: 2))
        textview.textContainerInset = UIEdgeInsets.zero
        
        if let card = data as? CardStoryElement{
            if let html =  card.text{
                textview.convert(toHtml: html, textOption: textOption.html)
            }
        }
        
        let height = textview.setLineHeight(lineHeight: 1.2, labelWidth: targetSize.width - 2 * 16)
        
        return CGSize.init(width: targetSize.width, height:ceil(height) + 2 * 16)
        
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
