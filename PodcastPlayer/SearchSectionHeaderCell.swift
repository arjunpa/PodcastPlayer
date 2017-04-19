//
//  SearchSectionHeaderCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/18/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit

class SearchSectionHeaderCell: BaseCollectionCell {

    let label: InsetLabel = {
        let label = InsetLabel()
        label.leftInset = 20
        label.numberOfLines = 1
       return label
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        
        let view = self.contentView
        view.addSubview(label)
        label.fillSuperview()

    }
    
    
    override func configure(data: Any?) {
        let title = data as? String
        label.text = title
        
    }
}
