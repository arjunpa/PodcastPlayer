//
//  PlayerControlsView.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 04/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

public class BasePlayerControlView:UIView{
    
    
    
    var minimumScaleValue:Float{
        get{return 0.0} set{}
    }
    
    var maximumScaleValue:Float{
        get{return 0.0} set{}
    }
    var setScaleValue:Float{
        get{return 0.0} set{}
    }
    
    public class func loadFromNib() -> BasePlayerControlView{
        fatalError("Override this")
    }
    
    public func sizeFit() -> CGSize{
        fatalError("override this")
    }
    
    public func updateTime(displayTime:String){
        fatalError("override this")
    }
    
    public func resetDisplay(){
        fatalError("Override this")
    }
    
    public func configurePLayerUI(){
        fatalError("Override this")
    }
    
}


public class PlayerControlsView: BasePlayerControlView {

    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistNameLable: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var containerView: UIView!
    
    var isSeeking:Bool = false
    var playing:Bool = false
    
    
    public override class func loadFromNib() -> PlayerControlsView{
        let nib = UINib.init(nibName: "PlayerControlsView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! PlayerControlsView
        
        view.configurePLayerUI()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }

    public override func sizeFit() -> CGSize{
        var compressedSize = UILayoutFittingCompressedSize
        compressedSize.width = UIScreen.main.bounds.width
        let sized = self.systemLayoutSizeFitting(compressedSize)
        return sized
    }
  
    override public func resetDisplay() {
        self.durationLabel.text = "00:00"
        self.durationLabel.text = "00:00"
        self.titleLabel.text = ""
        self.artistNameLable.text = ""
    }

    override public func configurePLayerUI() {
        self.resetDisplay()
        
        self.progressView.progressTintColor = UIColor(hexString:"#f76b1c")
    }
    
    
    
}
