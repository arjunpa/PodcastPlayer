//
//  MusicLayerController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 07/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype
import Kingfisher
import AVFoundation

class MusicLayerController: BaseViewController {
    
    var toolbar:PlayerControlsView = {
        
        let controlView = PlayerControlsView.loadFromNib()
        
        controlView.playButton.addTarget(self, action: #selector(MusicLayerController.didClickOnPlay(button:)), for: .touchUpInside)
        
        return controlView
        
    }()
    
    var isSeeking:Bool = false
    var isPlayerShown = false
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.qtObject.playerManager.multicastDelegate.addDelegate(delegate: self)
        self.loadPlayerView(toolbar: toolbar)

    }
    
    func loadPlayerView(toolbar:UIView){
        
        self.view.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 0)
        toolbar.frame = self.view.frame
        self.view.addSubview(toolbar)
        self.view.clipsToBounds = true
        
        self.toolbar.backgroundImage.applyGradient(colors: [UIColor(hexString:"#eb8241").withAlphaComponent(0.7),UIColor(hexString:"#000000").withAlphaComponent(0.7)], locations: nil, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1))
        
        toolbar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        toolbar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        toolbar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    deinit {
        self.qtObject.playerManager.multicastDelegate.removeDelegate(delegate: self)
    }
    
    func resetDisplay(){
        self.toolbar.durationLabel.text = "00:00"
        self.toolbar.progressView.progress = 0
    }
    
}

extension MusicLayerController:PlayerManagerDelegate{
    func playerManager(manager:PlayerManager,periodicTimeObserverEventDidOccur time:CMTimeWrapper) {
        
         let duration = manager.currentPlayerItemDuration
        
        if duration != kCMTimeIndefinite{
        let displayTime = formatTimeFromSeconds(seconds: duration.seconds - time.seconds)
        
        self.toolbar.durationLabel.text = "-\(displayTime)"
        }
    }
    
    func resetDisplayIfNecessary(manager:PlayerManager) {
        self.toolbar.durationLabel.text = "00:00"
        self.toolbar.progressView.progress = 0
    }
    
    func durationDidBecomeInvalidWhileSyncingScrubber(manager:PlayerManager){
        self.resetDisplay()
        self.toolbar.progressView.progress = 0
    }
    
    func playerManager(manager: PlayerManager, syncScrubberWithCurrent time: Double, duration:Double) {
        let minimumValue = Float64(0)
        let maximumValue = Float64(1)
        let currentTime = Float64(time)
        let progress = (maximumValue - minimumValue) * currentTime/(duration + minimumValue)
        
        self.toolbar.progressView.progress = Float(progress)
        
    }
    
    func setPlayButton(state:PlayerState){
        switch state {
        case .Playing:
            
            hideActivityIndicator()
            UIView.transition(with: self.toolbar.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.toolbar.playButton.setImage(#imageLiteral(resourceName: "pause_icon"), for: .normal)
            }, completion: nil)
            
        case .Paused:
            
            hideActivityIndicator()
            UIView.transition(with: self.toolbar.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.toolbar.playButton.setImage(UIImage(named: "play_icon"), for: .normal)
            }, completion: nil)
            
        case .Buffering:
            
            self.toolbar.playButton.setImage(nil, for: .normal)
            showActivityIndicator()
            break
            
        case .ReadyToPlay:
            
            self.toolbar.playButton.setImage(nil, for: .normal)
            showActivityIndicator()
            break
            
        case .Interrupted:
            
            break
        
        }
    }
    
    
    func setPlayeritemDuration(duration: Double) {
        let displayTime = formatTimeFromSeconds(seconds: duration)
        
        self.toolbar.durationLabel.text = "-\(displayTime)"
    }
    
    
    func didsetArtWorkWithUrl(url:URL?){
        if let unwrappedUrl = url{
            self.toolbar.backgroundImage.kf.setImage(with: URL(string:unwrappedUrl.absoluteString), placeholder: #imageLiteral(resourceName: "music_pholder"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            self.toolbar.backgroundImage.image = #imageLiteral(resourceName: "music_pholder")
        }
    }
    
    func didsetName(title: String?, AutorName: String?) {
        self.toolbar.titleLabel.text = title ?? "Unknown"
        self.toolbar.artistNameLable.text = AutorName ?? "Unknown"
    }
    
    func shouldShowMusicPlayer(shouldShow:Bool){
        let playerToolbarSize = self.toolbar.sizeFit()
        self.resetDisplay()
        
        if shouldShow{
            if self.view.frame.size.height == 0{
                
                self.view.frame.size.height = 0
                self.view.frame.origin.y = UIScreen.main.bounds.height - 50
                
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.view.frame.origin.y = UIScreen.main.bounds.height - (playerToolbarSize.height + 50)
                    self.view.frame.size.height = playerToolbarSize.height
                    
                }, completion:{(finished) -> Void in
                    self.isPlayerShown = true
                })
            }else{
                print("Player is already shown")
            }
            
        }else{
            if self.view.frame.size.height > 0{
                
                self.view.frame.origin.y = UIScreen.main.bounds.height - (playerToolbarSize.height + 50)
                self.view.frame.size.height = playerToolbarSize.height
                
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.view.frame.size.height = 0
                    self.view.frame.origin.y = UIScreen.main.bounds.height - 50
                    
                },  completion:{(finished) -> Void in
                    self.isPlayerShown = false
                })
            }else{
                print("Player is already hidden")
            }
        }
    }
    
    func showActivityIndicator(){
        
        //create only if not created before
        if  let unwrappedActivityIndicator = self.toolbar.playButton.subviews.filter({$0.isKind(of: UIActivityIndicatorView.self)}).first{
            unwrappedActivityIndicator.removeFromSuperview()
        }else{
           activityIndicator = createActivityIndicator()
        }
        
        self.toolbar.playButton.addSubview(activityIndicator)
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

    func shouldupdateTracksList(tracks: [TrackWrapper]?) {
        print("shouldupdateTracksList called for musicLayerController")
    }
}

extension MusicLayerController{
    
    func beginScrubbing(slider:UISlider){
        self.qtObject.playerManager.beginScrubbing()
    }
    
    
    func scrub(slider:UISlider){
//        self.qtObject.playerManager.scrub(value: self.toolbar.seeker.value, minValue: self.toolbar.seeker.minimumValue, maxValue: self.toolbar.seeker.maximumValue) { (seeking) in
//            self.isSeeking = seeking
//        }
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


