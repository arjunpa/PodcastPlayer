//
//  PlayerControlsView.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 04/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class PlayerControlsView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func loadFromNib() -> PlayerControlsView{
        let nib = UINib.init(nibName: "PlayerControlsView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! PlayerControlsView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func sizeFit() -> CGSize{
        var compressedSize = UILayoutFittingCompressedSize
        compressedSize.width = UIScreen.main.bounds.width
        let sized = self.systemLayoutSizeFitting(compressedSize)
        return sized
    }
}
