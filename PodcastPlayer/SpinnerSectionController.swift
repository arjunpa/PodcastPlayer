//
//  SpinnerSectionController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/12/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit

func spinnerSectionController() -> IGListSingleSectionController {
    let configureBlock = { (item: Any, cell: UICollectionViewCell) in
        guard let cell = cell as? SpinnerCell else { return }
        cell.activityIndicator.startAnimating()
    }
    
    let sizeBlock = { (item: Any, context: IGListCollectionContext?) -> CGSize in
        guard let context = context else { return .zero }
        return CGSize(width: context.containerSize.width, height: 60)
    }
    
    return IGListSingleSectionController(cellClass: SpinnerCell.self,
                                         configureBlock: configureBlock,
                                         sizeBlock: sizeBlock)

}

final class SpinnerCell: UICollectionViewCell {
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.hidesWhenStopped = true
        self.contentView.addSubview(view)
        return view
    }()
    
    
    func showActivity(){
        let bounds = contentView.bounds
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
        activityIndicator.startAnimating()
    }
}
