//
//  EmbededCollectionviewCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/18/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit

class EmbeddedCollectionViewCell: UICollectionViewCell {
    
    lazy var collectionView: IGListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = IGListCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
        self.contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.frame
    }
    
}
