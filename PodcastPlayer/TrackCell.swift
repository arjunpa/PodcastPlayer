//
//  TrackCell.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 05/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {

    @IBOutlet weak var textView:UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(trackWrapper:TrackWrapper){
        self.textView.text = trackWrapper.track.title
    }
    
    
    func cellSize(targetSize:CGSize, inset:UIEdgeInsets) -> CGSize{
        let widthConstraint = NSLayoutConstraint.init(item: self.contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: targetSize.width - inset.left - inset.right)
        widthConstraint.priority = 998
        self.contentView.addConstraint(widthConstraint)
        
        self.contentView.setNeedsUpdateConstraints()
        self.contentView.updateFocusIfNeeded()
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        
        var changeSize = UILayoutFittingCompressedSize
        changeSize.width = targetSize.width - inset.left - inset.right
        var calculatedSize = self.contentView.systemLayoutSizeFitting(changeSize, withHorizontalFittingPriority: 1000, verticalFittingPriority: 250)
        calculatedSize.height += inset.top
        calculatedSize.height += inset.bottom
        return calculatedSize
    }
}
