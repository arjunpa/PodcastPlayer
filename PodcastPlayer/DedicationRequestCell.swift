//
//  DedicationRequestCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/17/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype
import IGListKit

class DedicationRequestCell: BaseCollectionCell{
    
    let kMarginPadding:CGFloat = 16
    
    var currentTheam : Theme!
    
    let requestLabel : UILabel={
       let label = UILabel()
        label.numberOfLines = 2
        label.text = "Request Dedications"
        return label
    }()
    
    let requestButton : UIButton = {
       let button = UIButton()
        button.setTitle("REQUEST", for: .normal)
        button.titleLabel?.addTextSpacing(spacing: 1)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 1.0
        return button
    }()
    
    override func setupViews() {
        
        ThemeService.shared.addThemeable(themable: self)
        
        let view = self.contentView
 
        view.addSubview(requestLabel)
        view.addSubview(requestButton)
        
        requestLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: kMarginPadding, leftConstant: kMarginPadding, bottomConstant: kMarginPadding, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        requestButton.anchor(view.topAnchor, left: requestLabel.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: kMarginPadding, leftConstant: kMarginPadding, bottomConstant: kMarginPadding, rightConstant: kMarginPadding, widthConstant: 100, heightConstant: 30)
        
    }
    
    deinit{
        ThemeService.shared.removeThemeable(themable: self)
        print("DedicationRequestCell denit called")
    }
    
}

func dedicationRequestSectionController() -> IGListSingleSectionController{
    
    let configureBlock = { (item:Any, cell:UICollectionViewCell) in
        guard let cell = cell as? DedicationRequestCell else {return}
        
    }
    
    let sizeBlock = { (item:Any, context:IGListCollectionContext?) -> CGSize in
        guard let context = context else{return CGSize.zero}
        return CGSize(width: UIScreen.main.bounds.width, height: 62)
    }
    
    return IGListSingleSectionController(cellClass: DedicationRequestCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
    
}


extension DedicationRequestCell:Themeable{
    func applyTheme(theme: Theme) {
        if currentTheam == nil || type(of:theme) != type(of:currentTheam!){
        self.currentTheam = theme
        self.contentView.applyGradient(colors: theme.dedicationViewGradientColors,locations: nil,startPoint: CGPoint(x: 0, y: 0),endPoint: CGPoint(x: 1, y: 0))
        self.requestLabel.textColor = theme.dedicationTitleColor
        self.requestLabel.font = theme.dedicationTitleFont
        self.requestButton.backgroundColor = theme.dedicationRequestButtonColor
        self.requestButton.titleLabel?.font = theme.dedicationRequestButtonTitle
        }
    }
}
