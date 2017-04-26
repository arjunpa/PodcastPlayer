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

    @IBOutlet weak var authorlabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var displayTime:UILabel!
    @IBOutlet weak var seeker:UISlider!
    @IBOutlet weak var playerTappableArea: UIView!
    
    @IBOutlet weak var durationTimeLabel: UILabel!
    
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var playButton:UIButton!

    @IBOutlet weak var musicArtWorkImageView: UIImageView!
    
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
    
    override public var setScaleValue: Float{
        get{
            return seeker.value
        }
        set{
            seeker.value = newValue
        }
    }
    
    override public var maximumScaleValue:Float {
    get{
        return seeker.maximumValue
    }
        set{
            seeker.maximumValue = newValue
        }
    }

    override public var minimumScaleValue:Float {
        get{
          return seeker.minimumValue
        }
        set{
            seeker.maximumValue = newValue
        }
    }
    
    override public func updateTime(displayTime: String) {
        self.displayTime.text = displayTime
    }
    
    override public func resetDisplay() {
        self.displayTime.text = "00:00"
        self.seeker.value = 0.0
        self.durationTimeLabel.text = "00:00"
    }

    override public func configurePLayerUI() {
        self.resetDisplay()
        self.seeker.setThumbImage(UIImage(named:"thumb"), for: .normal)
        self.seeker.setThumbImage(UIImage(named:"thumbH"), for: .highlighted)
        
    }
    
    
    
}
