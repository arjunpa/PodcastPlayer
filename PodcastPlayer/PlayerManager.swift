//
//  PlayerManager.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import AVFoundation


private class AbstractPlayerManager:NSObject{
    
    
//    private override init(){
//        BackgroundPolicy = "Background_Policy"
//        super.init()
//    }

}


class PlayerManager: NSObject {
    
    //keep this really really duummmbbbbb
    fileprivate static var CURRENT_ITEM_CONTEXT:Int = 0
    fileprivate var playerItem:AVPlayerItem?
    fileprivate var timeObserver:Any?
    fileprivate  var _timeObserverQueue:DispatchQueue?
    fileprivate var timeObserverQueue:DispatchQueue{
        get{
            if _timeObserverQueue == nil{
                _timeObserverQueue = DispatchQueue.main
            }
            return _timeObserverQueue!
        }
        
        set{
            _timeObserverQueue = newValue
        }
    }
    
    
    
    public static let BackgroundPolicy:String = "Background_Policy"
    var player:AVPlayer!
    var playerControls:BasePlayerControlView?
    var scrubbingRate : Float!
    
    var currentPlayerItemDuration:CMTime{
        get{
            if self.player.currentItem == nil{
                return kCMTimeInvalid
            }
            return self.player.currentItem!.duration
        }
    }

    
    required init(playerAttributes:Dictionary<String,Any>?){
        super.init()
        commonInit()
        configure(playerAttributes: playerAttributes)
    }
    
    func configure(playerAttributes:Dictionary<String,Any>?){
        guard let attributes = playerAttributes else{return}
        
        if let bgPolicy = (attributes[PlayerManager.BackgroundPolicy] as? NSNumber)?.boolValue{
            if bgPolicy{
                PlayerManager.enableBackgroundPlay()
            }
        }
        
    }
    
    func registerClassForPlayerControls(classd:BasePlayerControlView.Type){
   
        playerControls = classd.loadFromNib()
        playerControls?.controlDelegate = self
        
    }
    
    private func commonInit(){
        player = AVPlayer.init()
    }
    
    func addObservers(){
        self.playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: &PlayerManager.CURRENT_ITEM_CONTEXT)
        
    }
    
    func removeObservers(){
        if self.playerItem != nil{
            self.playerItem?.removeObserver(self, forKeyPath: "status")
            self.playerItem = nil
        }
    }
    
    class func enableBackgroundPlay(){
        do{
          try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        }
        catch let avError{
            print(avError)
        }
    }
    
    func initTimeObserver(){
        
        var interval = 0.5
        //make the callback fire every half seconds
        let playerDuration = self.currentPlayerItemDuration
        
        if playerDuration == kCMTimeInvalid{
            return
        }
        // fire every half second. Ideally, 0.5 * factor. Factor = seekWidth/itemDuration
        if let seekWidth = playerControls?.sizeFit().width{
            if playerDuration.seconds.isFinite{
                interval = 0.5 * playerDuration.seconds / Double(seekWidth)
            }
        }
        
        timeObserver = self.player.addPeriodicTimeObserver(forInterval: CMTime.init(seconds: interval, preferredTimescale: CMTimeScale.init(NSEC_PER_SEC)), queue: timeObserverQueue) { (time) in
            self.playerControls?.updateTime(displayTime: formatTimeFromSeconds(seconds: CMTimeGetSeconds(time)))
            self.syncScrubber()
        }
        
    }
    
    func syncScrubber(){
        //update seeker position as music plays
        if self.currentPlayerItemDuration == kCMTimeInvalid{
            self.playerControls?.resetDisplay()
            self.playerControls!.minimumScaleValue = 0.0
            return
        }
        
        let durationSeconds = CMTimeGetSeconds(self.currentPlayerItemDuration)
        
        // Make sure the duration is finite. A live stream for example doesn't quantitively have a finite duration.
        if durationSeconds.isFinite{
            let minimumValue = Float64(self.playerControls!.minimumScaleValue)
            let maximumValue = Float64(self.playerControls!.maximumScaleValue)
            let currentTime = Float64(CMTimeGetSeconds(self.player.currentTime()))
            playerControls!.setScaleValue = Float((maximumValue - minimumValue) * currentTime/(durationSeconds + minimumValue))
        }
    }
    
    func deinitTimeObserver(){
        if timeObserver != nil{
            self.player.removeTimeObserver(timeObserver!)
            timeObserver = nil
        }
    }
    
    func playWithURL(url:URL){
        removeObservers()
        self.playerItem = AVPlayerItem.init(url: url)
        self.addObservers()
        player.replaceCurrentItem(with: playerItem!)
        self.playerControls?.resetDisplay()
    }
    
    
    deinit {
        deinitTimeObserver()
        removeObservers()
        timeObserver = nil
        playerItem = nil
    }
}

extension PlayerManager{
    
}

extension PlayerManager{
    // The player is going to take some time to buffer the remote resource and prepare it for play. So, only play the music when the player is ready.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath ?? "" == "status")  && context == &PlayerManager.CURRENT_ITEM_CONTEXT{
            if player.status == AVPlayerStatus.readyToPlay{
                initTimeObserver()
                player.play()
            }
            
            else if player.status == AVPlayerStatus.unknown{
                deinitTimeObserver()
            }
        }
        else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
extension PlayerManager:PlayerControlActionProtocol{
    func didClickOnNext(control: PlayerControlActionProtocol) {
        
    }
    
    func didClickOnPlay(control: PlayerControlActionProtocol,isPlaying playingValue:@escaping (Bool) -> ()) {
        if self.player.isPlaying{
            playingValue(true)
            self.player.pause()
        }else{
            playingValue(false)
            self.player.play()
        }
    }
    
    func didClickOnPrev(control: PlayerControlActionProtocol) {
        
    }
    
    /* The user is dragging the movie controller thumb to scrub through the movie. */
    func beginScrubbing() {
        scrubbingRate = self.player.rate
        self.player.rate = 0.0
        self.removeObservers()

    }
    
    /* The user has released the movie thumb control to stop scrubbing through the movie. */
    func endScrubbing() {
        var tolerance: Double = 0.5
        if let _ = timeObserver{
            let playerItemDuration = self.currentPlayerItemDuration
            if playerItemDuration == kCMTimeInvalid{
                return
            }
            let durationSeconds = playerItemDuration.seconds
            if durationSeconds.isFinite{
                if let width = self.playerControls?.sizeFit().width{
                    tolerance = 0.5 * durationSeconds/Double(width)
                }
            }
            
            timeObserver = self.player.addPeriodicTimeObserver(forInterval: CMTime.init(seconds: tolerance, preferredTimescale: CMTimeScale.init(NSEC_PER_SEC)), queue: timeObserverQueue, using: { (time) in
                self.syncScrubber()
            })
            
        }
        if scrubbingRate != nil{
            self.player.rate = scrubbingRate
            scrubbingRate = 0.0
        }
    }

    /* Set the player current time to match the scrubber position. */
    func scrub(isSeeking seekValue:@escaping (Bool) -> ()) {
        
        let playerItemDuration = self.currentPlayerItemDuration
        if playerItemDuration == kCMTimeInvalid{
            return
        }
        let durationSeconds = playerItemDuration.seconds
        if durationSeconds.isFinite{
            let minimumValue = Float64(self.playerControls!.minimumScaleValue)
            let maximumValue = Float64(self.playerControls!.maximumScaleValue)
            let value = Float64(self.playerControls!.setScaleValue)
            
            let time = durationSeconds * (value - minimumValue)/(maximumValue - minimumValue)
            self.player.seek(to: CMTimeMakeWithSeconds(time, CMTimeScale.init(NSEC_PER_SEC)), completionHandler: { (finished) in
                self.timeObserverQueue.async {
                    seekValue(false)
                }
            })
        }
        
        
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}



