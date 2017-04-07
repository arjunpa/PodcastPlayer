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
    
    @IBOutlet weak var playButton:UIButton! 
    
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
    
//    public func minimumScaleValue() -> Float{
//        return 0.0
//    }
//    public func maximumScaleValue() -> Float{
//        return 0.0
//    }
}


public class PlayerControlsView: BasePlayerControlView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var displayTime:UILabel!
    @IBOutlet weak var seeker:UISlider!
    
    var isSeeking:Bool = false
    var playing:Bool = false
    
    
    public override class func loadFromNib() -> PlayerControlsView{
        let nib = UINib.init(nibName: "PlayerControlsView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! PlayerControlsView
        view.translatesAutoresizingMaskIntoConstraints = false
        view.resetDisplay()
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
        self.displayTime.text = "00:00:00"
        self.seeker.value = 0.0
    }
    
//    @IBAction func scrub(_ sender: UISlider) {
//        if !isSeeking{
//            isSeeking = true
//            self.controlDelegate?.scrub(isSeeking: { (seekValue) in
//                self.isSeeking = seekValue
//            })
//        }
//    }
//    
//    
//    @IBAction func endScrubbing(_ sender: UISlider){
//        self.controlDelegate?.endScrubbing()
//    }
//    
//    
//    @IBAction func beginScrubbing(_ sender: UISlider){
//        self.controlDelegate?.beginScrubbing()
//    }
    
    
    @IBAction func playPauseButtonPressed(_ sender:UIButton){
     self.controlDelegate?.didClickOnPlay(control: self.controlDelegate!, isPlaying: { (isPlaying) in
        if isPlaying{
            UIView.transition(with: sender, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                sender.setImage(UIImage(named: "Play"), for: .normal)
            }, completion: nil)
        }else{
            UIView.transition(with: sender, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                sender.setImage(UIImage(named: "Pause"), for: .normal)
            }, completion: nil)
        }
     })
    }
    
    
    
    
    
    
    
    
    
}
