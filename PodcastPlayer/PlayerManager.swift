//
//  PlayerManager.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import AVFoundation



class CMTimeWrapper:NSObject{
    var seconds:Double
    var value:Int64
    var timeScale:Int32
    
    init(seconds:Double, value:Int64, timeScale:Int32) {
        self.seconds = seconds
        self.value = value
        self.timeScale = timeScale
        super.init()
    }
}

protocol PlayerManagerDataSource:class{
    func playerManagerDidReachEndOfCurrentItem(manager:PlayerManager)
    func playerManagerShoulMoveToNextItem(manager:PlayerManager) -> Bool
    func playerManagerShoulMoveToPreviousItem(manager:PlayerManager) -> Bool
    func playerManagerDidAskForNextItem(manager:PlayerManager) -> URL?
    func playerManagerDidAskForPreviousItem(manager:PlayerManager) -> URL?
}




protocol PlayerManagerDelegate:class{
    func playerManager(manager:PlayerManager,periodicTimeObserverEventDidOccur time:CMTimeWrapper)
    func resetDisplayIfNecessary(manager:PlayerManager)
    func durationDidBecomeInvalidWhileSyncingScrubber(manager:PlayerManager)
    func playerManager(manager: PlayerManager, syncScrubberWithCurrent time: Double, duration:Double)
    
}

class PlayerManager: NSObject {
    
    //keep this really really duummmbbbbb
    fileprivate static var CURRENT_ITEM_CONTEXT:Int = 0
    fileprivate var playerItem:AVPlayerItem?
    fileprivate var timeObserver:Any?
    fileprivate  var _timeObserverQueue:DispatchQueue?
    weak var dataSource:PlayerManagerDataSource?
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
    
    
    var bgTaskIdentifier = UIBackgroundTaskInvalid
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

    var lastURL:URL?
    
    typealias NotificationBlock = (Notification) -> ()
    fileprivate var playerItemDIdPlayToItem:NotificationBlock?
    
    var multicastDelegate:MulticastDelegate<PlayerManagerDelegate>!
    
    
    required init(playerAttributes:Dictionary<String,Any>?){
        super.init()
        commonInit()
        configure(playerAttributes: playerAttributes)
    }
    
    
    fileprivate func configurePlayerItemDidEndBlock(){
        self.playerItemDIdPlayToItem = {notification in
          self.beginBgTask()
            self.player.seek(to: kCMTimeZero, completionHandler: { (finished) in
                guard let datasource = self.dataSource else {self.removeStatusObservers(); return}
                datasource.playerManagerDidReachEndOfCurrentItem(manager: self)
                
                if datasource.playerManagerShoulMoveToNextItem(manager: self){
                    if let nextItemURL = datasource.playerManagerDidAskForNextItem(manager: self){
                        self.playWithURL(url: nextItemURL)
                        return
                    }
                    self.removeStatusObservers();
                }
                self.endBgTask()
            })
            
            
        }
    }
    
    func beginBgTask(){
        if self.bgTaskIdentifier == UIBackgroundTaskInvalid{
            self.bgTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
                UIApplication.shared.endBackgroundTask(self.bgTaskIdentifier)
                self.bgTaskIdentifier = UIBackgroundTaskInvalid
            })
        }
    }
    
    func endBgTask(){
        if self.bgTaskIdentifier != UIBackgroundTaskInvalid{
           DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5, execute: {
                UIApplication.shared.endBackgroundTask(self.bgTaskIdentifier)
                self.bgTaskIdentifier = UIBackgroundTaskInvalid
           })
          
        }
    }
    
    fileprivate func configure(playerAttributes:Dictionary<String,Any>?){
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
        multicastDelegate = MulticastDelegate<PlayerManagerDelegate>()
        player = AVPlayer.init()
        self.configurePlayerItemDidEndBlock()
    }
    
    

    
    
    fileprivate func addStatusObservers(){
        self.playerItem?.addObserver(self, forKeyPath: "status", options: [.initial, .new], context: &PlayerManager.CURRENT_ITEM_CONTEXT)
         self.playerItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: &PlayerManager.CURRENT_ITEM_CONTEXT)
         self.playerItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: &PlayerManager.CURRENT_ITEM_CONTEXT)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: OperationQueue.main, using: self.playerItemDIdPlayToItem!)
    }
    
    fileprivate func removeStatusObservers(){
        if self.playerItem != nil{
            self.playerItem?.removeObserver(self, forKeyPath: "status")
            self.playerItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
            self.playerItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
            self.playerItem = nil
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    
    
    
    class func enableBackgroundPlay(){
        do{
          try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
          try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let avError{
            print(avError)
        }
    }
    
    fileprivate func initTimeObserver(){
        
        var interval = 0.5
        //make the callback fire every half seconds
        let playerDuration = self.currentPlayerItemDuration
        
        if playerDuration == kCMTimeInvalid{
            return
        }
        // fire every half second. Ideally, 0.5 * factor. Factor = seekWidth/itemDuration
//        if let seekWidth = playerControls?.sizeFit().width{
//            if playerDuration.seconds.isFinite{
//               // interval = 0.5 * playerDuration.seconds / Double(seekWidth)
//            }
//        }
        
        timeObserver = self.player.addPeriodicTimeObserver(forInterval: CMTime.init(seconds: interval, preferredTimescale: CMTimeScale.init(NSEC_PER_SEC)), queue: timeObserverQueue) { (time) in
            
            self.multicastDelegate.invoke(invokation: { (delegate:PlayerManagerDelegate) in
                delegate.playerManager(manager: self, periodicTimeObserverEventDidOccur: CMTimeWrapper.init(seconds: CMTimeGetSeconds(time), value: time.value, timeScale: time.timescale))
            })
            
            self.syncScrubber()
        }
        
    }
    
    func syncScrubber(){
        //update seeker position as music plays
        if self.currentPlayerItemDuration == kCMTimeInvalid{

            self.multicastDelegate.invoke(invokation: { (delegate:PlayerManagerDelegate) in
                delegate.durationDidBecomeInvalidWhileSyncingScrubber(manager: self)
            })
            return
        }
        
        let durationSeconds = CMTimeGetSeconds(self.currentPlayerItemDuration)
        
        // Make sure the duration is finite. A live stream for example doesn't quantitively have a finite duration.
        if durationSeconds.isFinite{
            self.multicastDelegate.invoke(invokation: { (delegate) in
                delegate.playerManager(manager: self, syncScrubberWithCurrent: CMTimeGetSeconds(self.player.currentTime()), duration: durationSeconds)
            })
        }
    }
    
    fileprivate func deinitTimeObserver(){
        if timeObserver != nil{
            self.player.removeTimeObserver(timeObserver!)
            timeObserver = nil
        }
    }
    
    func playWithURL(url:URL){
        removeStatusObservers()
        self.playerItem = AVPlayerItem.init(url: url)
        self.addStatusObservers()
        player.replaceCurrentItem(with: playerItem!)
        self.playerControls?.resetDisplay()
        self.lastURL = url
    }
    
    func didClickOnPlay(){
        if !self.player.isPlaying{
            if let lastURL = self.lastURL{
                self.playWithURL(url: lastURL)
            }
        }
    }
    
    
    deinit {
        deinitTimeObserver()
        removeStatusObservers()
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
        else if  (keyPath ?? "" == "playbackLikelyToKeepUp")  && context == &PlayerManager.CURRENT_ITEM_CONTEXT{
        
            if self.playerItem?.isPlaybackLikelyToKeepUp ?? false{
                if UIApplication.shared.applicationState == .background{
                    self.player.play()
                    self.endBgTask()
                }
              //  self.player.play()
            }
        }
        else if  (keyPath ?? "" == "playbackBufferEmpty")  && context == &PlayerManager.CURRENT_ITEM_CONTEXT{
            
            if self.playerItem?.isPlaybackBufferEmpty ?? false{
                if UIApplication.shared.applicationState == .background{
                    self.beginBgTask()
                }
            }
        }
            
        else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
extension PlayerManager:PlayerControlActionProtocol{
    internal func scrub(isSeeking seekValue: @escaping (Bool) -> ()) {
        
    }

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
        //self.removeObservers()
        self.deinitTimeObserver()

    }
    
    /* The user has released the movie thumb control to stop scrubbing through the movie. */
    func endScrubbing() {
        var tolerance: Double = 0.5
        if timeObserver == nil{
            let playerItemDuration = self.currentPlayerItemDuration
            if playerItemDuration == kCMTimeInvalid{
                return
            }
          initTimeObserver()
            
        }
        if scrubbingRate != nil{
            self.player.rate = scrubbingRate
            scrubbingRate = 0.0
        }
    }

    /* Set the player current time to match the scrubber position. */
//    func scrub(isSeeking seekValue:@escaping (Bool) -> ()) {
//        
//        let playerItemDuration = self.currentPlayerItemDuration
//        if playerItemDuration == kCMTimeInvalid{
//            return
//        }
//        let durationSeconds = playerItemDuration.seconds
//        if durationSeconds.isFinite{
//            let minimumValue = Float64(self.playerControls!.minimumScaleValue)
//            let maximumValue = Float64(self.playerControls!.maximumScaleValue)
//            let value = Float64(self.playerControls!.setScaleValue)
//            
//            let time = durationSeconds * (value - minimumValue)/(maximumValue - minimumValue)
//            
//              self.playerControls?.updateTime(displayTime: formatTimeFromSeconds(seconds: time))
//            
//            self.player.seek(to: CMTimeMakeWithSeconds(time, CMTimeScale.init(NSEC_PER_SEC)), completionHandler: { (finished) in
//                self.timeObserverQueue.async {
//                    seekValue(false)
//                }
//            })
//            
//        }
//        
//        
//    }
    
    func scrub(value:Float,minValue:Float,maxValue:Float,isSeeking seekValue:@escaping (Bool) -> ()) {
        let playerItemDuration = self.currentPlayerItemDuration
        if playerItemDuration == kCMTimeInvalid{
            return
        }
        let durationSeconds = playerItemDuration.seconds
        if durationSeconds.isFinite{
            let minimumValue = Float64(minValue)
            let maximumValue = Float64(maxValue)
            let valued = Float64(value)
            let time = durationSeconds * (valued - minimumValue)/(maximumValue - minimumValue)
            let cmTime = CMTime.init(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            self.multicastDelegate.invoke(invokation: { (delegate) in
                delegate.playerManager(manager: self, periodicTimeObserverEventDidOccur: CMTimeWrapper.init(seconds: time, value: cmTime.value, timeScale: cmTime.timescale))
            })
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



