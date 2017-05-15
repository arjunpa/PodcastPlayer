//
//  PLayerHeaderCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/11/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher

protocol PLayerHeaderViewDeleagte {
    func tracksDidChange(tracks:[TrackWrapper]?)
    func trackDidChange()
}

class PLayerHeaderView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var trackNameLabel: MarqueeLabel!
    
    @IBOutlet weak var artistLabel: MarqueeLabel!
    
    @IBOutlet weak var slider: CustomSlider!
    
    @IBOutlet weak var startLabel: UILabel!
    
    @IBOutlet weak var endLabel: UILabel!
    
    @IBOutlet weak var buttonsContainerView: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var skipReverseButton: UIButton!
    
    @IBOutlet weak var trackImageView: UIImageView!
    
    var qtObject : QTGlobalProtocol!
    
    var activityIndicator = UIActivityIndicatorView()
    
    var delegate: PLayerHeaderViewDeleagte?
    
    class func loadFromNib(qtObject:QTGlobalProtocol) -> PLayerHeaderView{
        let nib = UINib.init(nibName: "PLayerHeaderView", bundle: nil)
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! PLayerHeaderView
        
        view.qtObject = qtObject
        
        view.setupView()
        
        let widthConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width)
        view.addConstraint(widthConstraint)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
    
    func setupView(){
        self.backgroundColor = .purple
        
        self.qtObject.playerManager.multicastDelegate.addDelegate(delegate: self)
        
        self.qtObject.playerManager.updatePlayerUI()
        
        slider.isUserInteractionEnabled = true
        
        slider.addTarget(self, action: #selector(self.beginScrubbing(slider:)), for: .touchDown)
        slider.addTarget(self, action: #selector(self.scrub(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(self.scrub(slider:)), for: .touchDragInside)
        slider.addTarget(self, action: #selector(self.endScrubbing(slider:)), for: .touchCancel)
        slider.addTarget(self, action: #selector(self.endScrubbing(slider:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(self.endScrubbing(slider:)), for: .touchUpOutside)
        
        playButton.addTarget(self, action: #selector(self.didClickOnPlay(button:)), for: .touchUpInside)
        
        nextButton.addTarget(self, action: #selector(self.didClickOnNext(sender:)),for:.touchUpInside)
        
        skipReverseButton.addTarget(self, action: #selector(self.rewindButtonPressed(sender:)), for: .touchUpInside)
        
        skipReverseButton.addTarget(self, action: #selector(self.previousButtonPressed(_:event:)), for: .touchDownRepeat)
        
        beautifyPlayer()
        
        artistLabel.type = .continuous
        artistLabel.speed = .rate(35)
        artistLabel.animationCurve = .easeInOut
        artistLabel.fadeLength = 10
        artistLabel.textAlignment = .center
        artistLabel.leadingBuffer = 30
        artistLabel.trailingBuffer = 20
        
        trackNameLabel.type = .continuous
        trackNameLabel.speed = .rate(35)
        trackNameLabel.animationCurve = .easeInOut
        trackNameLabel.fadeLength = 10
        trackNameLabel.textAlignment = .center
        trackNameLabel.leadingBuffer = 30
        trackNameLabel.trailingBuffer = 20
    }
    
    func beautifyPlayer(){
        
        trackNameLabel.textColor = ThemeService.shared.theme.playerSongTitleColor
        trackNameLabel.font = ThemeService.shared.theme.playerSongTitlelabelFont
        
        artistLabel.textColor = ThemeService.shared.theme.playerArtistLabelColor
        artistLabel.font = ThemeService.shared.theme.playerArtistLabelFont
        
        startLabel.textColor = ThemeService.shared.theme.playerSeekerLabelColor
        startLabel.font = ThemeService.shared.theme.playerSeekerLabelFont
        
        endLabel.textColor = ThemeService.shared.theme.playerSeekerLabelColor
        endLabel.font = ThemeService.shared.theme.playerSeekerLabelFont
        
        self.trackImageView.applyGradient(colors: [UIColor(hexString:"#eb8241").withAlphaComponent(0.35),UIColor(hexString:"#000000").withAlphaComponent(0.75)], locations: nil, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        self.slider.setThumbImage(UIImage(named:"thumb"), for: .normal)
        self.slider.setThumbImage(UIImage(named:"thumbH"), for: .highlighted)
        
        self.slider.minimumTrackTintColor = UIColor(hexString:"#f76b1c")
        self.slider.maximumTrackTintColor = UIColor(hexString:"#ffffff").withAlphaComponent(0.30)
        
        self.slider.setMinimumTrackImage(#imageLiteral(resourceName: "grad"), for: .normal)
        
        self.resetDisplay()
    }
    
    func configure(){
        
    }
  
    deinit {
        self.qtObject.playerManager.multicastDelegate.removeDelegate(delegate: self)
    }
    
    func resetDisplay(){
        self.startLabel.text = "00:00"
        self.endLabel.text = "00:00"
        self.slider.value = 0
    }
}

extension PLayerHeaderView:PlayerManagerDelegate{
    
    func playerManager(manager:PlayerManager,periodicTimeObserverEventDidOccur time:CMTimeWrapper) {
        
        let duration = manager.currentPlayerItemDuration
        
        if duration != kCMTimeIndefinite{
            let endTime = formatTimeFromSeconds(seconds: duration.seconds - time.seconds)
            let startTime = formatTimeFromSeconds(seconds: time.seconds)
            
            self.startLabel.text = "\(startTime)"
            self.endLabel.text = "-\(endTime)"
        }
    }
    
    func resetDisplayIfNecessary(manager:PlayerManager) {
        self.startLabel.text = "00:00"
        self.endLabel.text = "00:00"
        self.slider.value = 0
    }
    
    func durationDidBecomeInvalidWhileSyncingScrubber(manager:PlayerManager){
        self.resetDisplay()
        self.slider.value = 0
    }
    
    func playerManager(manager: PlayerManager, syncScrubberWithCurrent time: Double, duration:Double) {
        let minimumValue = Float64(0)
        let maximumValue = Float64(1)
        let currentTime = Float64(time)
        let progress = (maximumValue - minimumValue) * currentTime/(duration + minimumValue)
        
        self.slider.value = Float(progress)
        
    }
    
    func setPlayButton(state:PlayerState){
        switch state {
        case .Playing:
            
            hideActivityIndicator()
            UIView.transition(with: self.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.playButton.setImage(#imageLiteral(resourceName: "pause_icon"), for: .normal)
            }, completion: nil)
            
        case .Paused:
            
            hideActivityIndicator()
            UIView.transition(with: self.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.playButton.setImage(UIImage(named: "play_icon"), for: .normal)
            }, completion: nil)
            
        case .Buffering:
            
            self.playButton.setImage(nil, for: .normal)
            showActivityIndicator()
            break
            
        case .ReadyToPlay:
            
            self.playButton.setImage(nil, for: .normal)
            showActivityIndicator()
            break
            
        case .Interrupted:
            
            break
            
        }
    }
    
    
    func setPlayeritemDuration(duration: Double) {
        let displayTime = formatTimeFromSeconds(seconds: duration)
        
        self.startLabel.text = "00:00"
        self.endLabel.text = "-\(displayTime)"
        
        delegate?.trackDidChange()
        
    }
    
    
    func didsetArtWorkWithUrl(url:URL?){
        if let unwrappedUrl = url{
            self.trackImageView.kf.setImage(with: URL(string:unwrappedUrl.absoluteString), placeholder: #imageLiteral(resourceName: "music_pholder"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            self.trackImageView.image = #imageLiteral(resourceName: "music_pholder")
        }
    }
    
    func didsetName(title: String?, AutorName: String?) {
        self.trackNameLabel.text = title ?? "Unknown"
        self.artistLabel.text = AutorName ?? "Unknown"
    }
    
    func shouldShowMusicPlayer(shouldShow:Bool){
       
    }
    
    func showActivityIndicator(){
        
        //create only if not created before
        if  let unwrappedActivityIndicator = self.playButton.subviews.filter({$0.isKind(of: UIActivityIndicatorView.self)}).first{
            unwrappedActivityIndicator.removeFromSuperview()
        }else{
            activityIndicator = createActivityIndicator()
        }
        
        self.playButton.addSubview(activityIndicator)
        activityIndicator.anchorCenterSuperview()
        activityIndicator.startAnimating()
        
    }
    
    func hideActivityIndicator(){
        activityIndicator.stopAnimating()
    }
    
    func createActivityIndicator() -> UIActivityIndicatorView{
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        
        activityIndicator.color = UIColor.white
        
        return activityIndicator
    }
    
}

extension PLayerHeaderView{
    
    func beginScrubbing(slider:UISlider){
        self.qtObject.playerManager.beginScrubbing()
    }
    
    func scrub(slider:UISlider){
        self.qtObject.playerManager.scrub(value: self.slider.value, minValue: self.slider.minimumValue, maxValue: self.slider.maximumValue) { (seeking) in
            print(seeking)
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
    
    
    func rewindButtonPressed(sender:UIButton){
        let currentTime = self.qtObject.playerManager.player.currentTime()
        let playerDuration = self.qtObject.playerManager.currentPlayerItemDuration
        
        let seekValue = (currentTime.seconds - 10)/playerDuration.seconds
        
        self.qtObject.playerManager.didRewindTenSeconds(value: Float(seekValue))
    }
    
    func previousButtonPressed(_ sender:UIButton,event:UIEvent){
        let touch :UITouch = (event.allTouches?.first)!
        if touch.tapCount >= 2{
            self.qtObject.playerManager.didClickOnPrevious()
        }
    }
    
    func shouldupdateTracksList(tracks: [TrackWrapper]?) {
        delegate?.tracksDidChange(tracks: tracks)
    }
}
