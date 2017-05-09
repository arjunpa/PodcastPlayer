//
//  RelatedStoriesTitleCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/9/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

final class RelatedStoriesTitleCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = ThemeService.shared.theme.primaryColor
        label.font = ThemeService.shared.theme.relatedStoriesSectionTitleFont
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        label.anchor(self.contentView.topAnchor, left: self.contentView.leftAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        return label
    }()
    
    func setText(text:String){
        self.titleLabel.text = text
    }
}
