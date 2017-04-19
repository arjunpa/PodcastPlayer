//
//  BaseCollectionCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

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
}
