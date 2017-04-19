//
//  DedicationRequestCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/17/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype
class DedicationRequestCell: BaseCollectionCell{
    
    let kMarginPadding:CGFloat = 16
    let requestLabel : UILabel={
       let label = UILabel()
        label.numberOfLines = 2
        label.text = "Request Dedications"
        return label
    }()
    
    let requestButton : UIButton = {
       let button = UIButton()
        button.setTitle("REQUEST", for: .normal)
        
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        let view = self.contentView
        view.backgroundColor = UIColor(hexString: "#FEE5C1")
        view.addSubview(requestLabel)
        view.addSubview(requestButton)
        requestLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: kMarginPadding, leftConstant: kMarginPadding, bottomConstant: kMarginPadding, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        requestButton.anchor(view.topAnchor, left: requestLabel.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: kMarginPadding, leftConstant: kMarginPadding, bottomConstant: kMarginPadding, rightConstant: kMarginPadding, widthConstant: 100, heightConstant: 30)
    }
    
    
}
