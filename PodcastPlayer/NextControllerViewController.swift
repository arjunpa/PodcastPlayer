//
//  NextControllerViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 11/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class NextControllerViewController: BaseViewController {
    @IBOutlet weak var rewindButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var displaylabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var rootViewController: ViewController?
    var isSeeking:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.qtObject.playerManager.multicastDelegate.addDelegate(delegate: self)
        
        slider.addTarget(self, action: #selector(NextControllerViewController.beginScrubbing(slider:)), for: .touchDown)
        slider.addTarget(self, action: #selector(NextControllerViewController.scrub(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(NextControllerViewController.scrub(slider:)), for: .touchDragInside)
        slider.addTarget(self, action: #selector(NextControllerViewController.endScrubbing(slider:)), for: .touchCancel)
        slider.addTarget(self, action: #selector(NextControllerViewController.endScrubbing(slider:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(NextControllerViewController.endScrubbing(slider:)), for: .touchUpOutside)
        playButton.addTarget(self, action: #selector(NextControllerViewController.didClickOnPlay(button:)), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(NextControllerViewController.didClickOnNext(sender:)),for:.touchUpInside)
        if self.qtObject.playerManager.player.isPlaying{
            playButton.setImage(UIImage(named:"Pause"), for: .normal)
        }
        
    }
    
    func resetDisplay(){
        self.durationLabel.text = "00:00"
        self.slider.value = 0.0
    }
    
    deinit {
        self.qtObject.playerManager.multicastDelegate.removeDelegate(delegate: self)
    }
    
    
}

extension NextControllerViewController:PlayerManagerDelegate{
    func playerManager(manager:PlayerManager,periodicTimeObserverEventDidOccur time:CMTimeWrapper) {
        let displayTime = formatTimeFromSeconds(seconds: time.seconds)
        self.displaylabel.text = displayTime
    }
    
    func resetDisplayIfNecessary(manager:PlayerManager) {
        self.displaylabel.text = "00:00"
        self.slider.value = 0.0
    }
    
    func durationDidBecomeInvalidWhileSyncingScrubber(manager:PlayerManager){
        self.resetDisplay()
        self.slider.minimumValue = 0.0
    }
    
    func playerManager(manager: PlayerManager, syncScrubberWithCurrent time: Double, duration:Double) {
        
    }
    
    func setPlayButton(state:PlayerState){
        switch state {
        case .Playing:
            UIView.transition(with: self.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.playButton.setImage(UIImage(named: "Pause"), for: .normal)
            }, completion: nil)
        case .Paused:
            UIView.transition(with: self.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.playButton.setImage(UIImage(named: "Play"), for: .normal)
            }, completion: nil)
        default:
            break
        }
    }
    
    func setPlayeritemDuration(duration: Double) {
        let displayTime = formatTimeFromSeconds(seconds: duration)
        
        self.durationLabel.text = displayTime
    }
    
    
    func didsetArtWorkWithUrl(url:URL?){
        //        if let unwrappedUrl = url{
        //            self.toolbar.musicArtWorkImageView.loadImage(url: unwrappedUrl.absoluteString, targetSize: CGSize(width: 100, height: 100))
        //        }else{
        //            self.toolbar.musicArtWorkImageView.image = UIImage.init(named: "author")
        //        }
    }
    
    func didsetName(title: String?, AutorName: String?) {
        //        self.toolbar.titleLabel.text = title ?? "Unknown"
        //        self.toolbar.authorlabel.text = AutorName ?? "Unknown"
    }
    
    func shouldShowMusicPlayer(shouldShow:Bool){
        
    }
}

extension NextControllerViewController{
    
    func beginScrubbing(slider:UISlider){
        self.qtObject.playerManager.beginScrubbing()
    }
    
    
    func scrub(slider:UISlider){
        self.qtObject.playerManager.scrub(value: self.slider.value, minValue: self.slider.minimumValue, maxValue: self.slider.maximumValue) { (seeking) in
            self.isSeeking = seeking
        }
    }
    
    
    func endScrubbing(slider:UISlider){
        self.qtObject.playerManager.endScrubbing()
    }
    
    func didClickOnPlay(button:UIButton){
        self.qtObject.playerManager.didClickOnPlay()
    }
    
    func didClickOnNext(sender:UIButton){
        self.qtObject.playerManager.didClickOnNext()
    }
    
    func forwardButtonHeld(sender: UILongPressGestureRecognizer){
        
        if sender.state == .ended{
            print("ended")
            self.qtObject.playerManager.didFastForward(withRate:1)
        }else if sender.state == .began{
            print("began")
            self.qtObject.playerManager.didFastForward(withRate:2)
        }
        
        print(#function)
    }
    
}
