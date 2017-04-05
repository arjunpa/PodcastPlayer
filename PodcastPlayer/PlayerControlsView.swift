//
//  PlayerControlsView.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 04/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

public class BasePlayerControlView:UIView{
    
    weak var controlDelegate:PlayerControlActionProtocol?
    
    public class func loadFromNib() -> BasePlayerControlView{
        fatalError("Override this")
    }
    
    public func sizeFit() -> CGSize{
        fatalError("override this")
    }
}


public class PlayerControlsView: BasePlayerControlView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public override class func loadFromNib() -> PlayerControlsView{
        let nib = UINib.init(nibName: "PlayerControlsView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! PlayerControlsView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    public override func sizeFit() -> CGSize{
        var compressedSize = UILayoutFittingCompressedSize
        compressedSize.width = UIScreen.main.bounds.width
        let sized = self.systemLayoutSizeFitting(compressedSize)
        return sized
    }
}
