//
//  PlayerManager.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Quintype

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
    func playerManagerDidAskForArtWorksImageUrl(manager:PlayerManager,size:TrackArtworkImageSize) -> URL?
    func playerManagerDidAskForTrackTitleAndAuthor(manager:PlayerManager) -> (String,String)
    
}


protocol PlayerManagerDelegate:class{
    
    func playerManager(manager:PlayerManager,periodicTimeObserverEventDidOccur time:CMTimeWrapper)
    func resetDisplayIfNecessary(manager:PlayerManager)
    func durationDidBecomeInvalidWhileSyncingScrubber(manager:PlayerManager)
    func playerManager(manager: PlayerManager, syncScrubberWithCurrent time: Double, duration:Double)
    
    func setPlayButton(state:PlayerState)
    
    func setPlayeritemDuration(duration:Double)
    func didsetArtWorkWithUrl(url:URL?)
    func didsetName(title:String?,AutorName:String?)
    func shouldShowMusicPlayer(shouldShow:Bool)
    
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
    // var playerControls:BasePlayerControlView?
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
    var kInterval = 0.5
    var playerState: PlayerState!
    
    
    var commandCenter: MPRemoteCommandCenter!
    var nowPlayingInfoCenter: MPNowPlayingInfoCenter!
    var notificationCenter: NotificationCenter!
    
    var nowPlayingInfo: [String : AnyObject]?
    
    required init(playerAttributes:Dictionary<String,Any>?){
        super.init()
        commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.seekForwardCommand.isEnabled = true
        commandCenter.seekBackwardCommand.isEnabled = true
        
        nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        notificationCenter = NotificationCenter.default
        commonInit()
        configure(playerAttributes: playerAttributes)
        
        self.configureCommandCenter()
    }
    
    fileprivate func configurePlayerItemDidEndBlock(){
        
        self.playerItemDIdPlayToItem = {notification in
            self.beginBgTask()
            self.player.seek(to: kCMTimeZero, completionHandler: { (finished) in
                guard let datasource = self.dataSource else {self.removeStatusObservers(); return}
                datasource.playerManagerDidReachEndOfCurrentItem(manager: self)
                
                let isPlaying = self.player.actionAtItemEnd
                
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
    
    private func commonInit(){
        multicastDelegate = MulticastDelegate<PlayerManagerDelegate>()
        player = AVPlayer.init()
        self.configurePlayerItemDidEndBlock()
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
        
        let interval = kInterval
        //make the callback fire every half seconds
        let playerDuration = self.currentPlayerItemDuration
        
        if playerDuration == kCMTimeInvalid{
            return
        }
        
        timeObserver = self.player.addPeriodicTimeObserver(forInterval: CMTime.init(seconds: interval, preferredTimescale: CMTimeScale.init(NSEC_PER_SEC)), queue: timeObserverQueue) { (time) in
            
            self.multicastDelegate.invoke(invokation: { (delegate:PlayerManagerDelegate) in
                delegate.playerManager(manager: self, periodicTimeObserverEventDidOccur: CMTimeWrapper.init(seconds: CMTimeGetSeconds(time), value: time.value, timeScale: time.timescale))
            })
            
            self.syncScrubber()
        }
        
    }
    
    func setUpPlayerUI(){
        
       
        
        //set the duration
        let playerDuration = self.currentPlayerItemDuration
        self.multicastDelegate.invoke { (delegate) in
            if !playerDuration.flags.contains(CMTimeFlags.indefinite){
                delegate.setPlayeritemDuration(duration: playerDuration.seconds)
            }else{
                print("Player Duration Not valid")
            }
        }
        
        //set artwork Image
        guard let datasource = self.dataSource else {self.removeStatusObservers(); return}
        
        let unwrappedUrl = datasource.playerManagerDidAskForArtWorksImageUrl(manager: self,size: .small)
        let trackname = datasource.playerManagerDidAskForTrackTitleAndAuthor(manager: self)
        
        self.multicastDelegate.invoke(invokation: { (delegate:PlayerManagerDelegate) in
            delegate.didsetArtWorkWithUrl(url: unwrappedUrl)
            delegate.didsetName(title: trackname.0,AutorName: trackname.1)
        })
        
        
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
        self.lastURL = url
        self.multicastDelegate.invoke { (delegate) in
            delegate.shouldShowMusicPlayer(shouldShow: true)
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
    
    fileprivate func addStatusObservers(){
        self.playerItem?.addObserver(self, forKeyPath: "status", options: [.initial, .new], context: &PlayerManager.CURRENT_ITEM_CONTEXT)
        self.playerItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: &PlayerManager.CURRENT_ITEM_CONTEXT)
        self.playerItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: &PlayerManager.CURRENT_ITEM_CONTEXT)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: OperationQueue.main, using: self.playerItemDIdPlayToItem!)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruptions(_:)), name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
        
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "AVPlayerItemBecameCurrentNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleVideoPlaying(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemBecameCurrentNotification"), object: nil)
        
    }
    
    func handleVideoPlaying(_ notification:Notification){
        print(notification.name)
        print("came here")
        if let object = notification.object as? AVPlayerItem{
            if object.asset.tracks(withMediaType: AVMediaTypeVideo).count == 0{
                print("Playing audio")
            }else{
                print("Playing Video")
                    self.didClickOnPlay()
                
            }
        }
    }
    
    func handleInterruptions(_ notification:Notification){
        
        guard let typeKey = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt,let interruptionType = AVAudioSessionInterruptionType(rawValue: typeKey) else{
            return
        }
        
        switch interruptionType {
        case .began:
            print("began")
            self.player.pause()
            break
        case .ended:
            print("ended")
            self.player.play()
            break
        }
        
    }
    
    // The player is going to take some time to buffer the remote resource and prepare it for play. So, only play the music when the player is ready.
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        
        if (keyPath ?? "" == "status")  && context == &PlayerManager.CURRENT_ITEM_CONTEXT{
            if player.status == AVPlayerStatus.readyToPlay{
                self.playerState = PlayerState.ReadyToPlay
                
                print("KEYPATH:\(keyPath):player Status AVPlayerStatus.readyToPlay")
                
                initTimeObserver()
                setUpPlayerUI()
                player.play()
                
                //set play button
                self.multicastDelegate.invoke { (delegate) in
                    delegate.setPlayButton(state: PlayerState.ReadyToPlay)
                }
                

            }else if player.status == AVPlayerStatus.unknown{
                self.playerState = PlayerState.Interrupted
                deinitTimeObserver()
            }
        }
            
        else if  (keyPath ?? "" == "playbackLikelyToKeepUp")  && context == &PlayerManager.CURRENT_ITEM_CONTEXT{
            
            if self.playerItem?.isPlaybackLikelyToKeepUp ?? false{
                
                //set play button
                self.multicastDelegate.invoke { (delegate) in
                    delegate.setPlayButton(state: PlayerState.Playing)
                }
                
                print("KEYPATH:\(keyPath):player Item Status isPlaybackLikelyToKeepUp")
                
                //update the control center after buffering is finished
                
                self.updateNowPlayingInfoForCurrentPlaybackItem()
                
                if UIApplication.shared.applicationState == .background{
                    self.player.play()
                    self.endBgTask()
                }
                
            }else{
                print("KEYPATH:\(keyPath):player Item Status Playback NOT LikelyToKeepUp")
                print("buffering")
            }
        }
        else if  (keyPath ?? "" == "playbackBufferEmpty")  && context == &PlayerManager.CURRENT_ITEM_CONTEXT{
            
            self.playerState = PlayerState.Buffering
            
            //set play button
            self.multicastDelegate.invoke { (delegate) in
                delegate.setPlayButton(state: PlayerState.Buffering)
            }
            
            if self.playerItem?.isPlaybackBufferEmpty ?? false{
                print("KEYPATH:\(keyPath):player Item Status isPlaybackBufferEmpty")
                if UIApplication.shared.applicationState == .background{
                    self.beginBgTask()
                }
            }else{
                print("buffer Not empty")
            }
        }
            
        else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}


//MARK: - Player Actions

extension PlayerManager{
    
    /* The user is dragging the movie controller thumb to scrub through the movie. */
    func beginScrubbing() {
        scrubbingRate = self.player.rate
        self.player.rate = 0.0
        //self.removeObservers()
        self.deinitTimeObserver()
        
    }
    
    /* The user has released the movie thumb control to stop scrubbing through the movie. */
    func endScrubbing() {
        
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
            
            
            self.nowPlayingInfo?[MPNowPlayingInfoPropertyElapsedPlaybackTime] = NSNumber(value: time as Double);
            self.nowPlayingInfoCenter.nowPlayingInfo = self.nowPlayingInfo
            
            self.player.seek(to: CMTimeMakeWithSeconds(time, CMTimeScale.init(NSEC_PER_SEC)), completionHandler: { (finished) in
                self.timeObserverQueue.async {
                    seekValue(false)
                }
            })
            
        }
    }
    
    func didClickOnPlay(){
        if !self.player.isPlaying{
            self.player.rate = 1

            self.multicastDelegate.invoke { (delegate) in
                delegate.setPlayButton(state: PlayerState.Playing)
            }
            
        }else{
            self.player.rate = 0
            
            self.multicastDelegate.invoke { (delegate) in
                delegate.setPlayButton(state: PlayerState.Paused)
            }

        }
    }
    
    func didClickOnNext(){
        
        guard let datasource = self.dataSource else {self.removeStatusObservers(); return}
        
        self.multicastDelegate.invoke { (delegate) in
                delegate.resetDisplayIfNecessary(manager: self)
        }
        
        resetNowPlayingInfoCenter()
        
        if datasource.playerManagerShoulMoveToNextItem(manager: self){
            if let nextItemURL = datasource.playerManagerDidAskForNextItem(manager: self){
                self.playWithURL(url: nextItemURL)
                return
            }
            self.removeStatusObservers();
        }
    }
    
    func didClickOnPrevious(){
        guard let datasource = self.dataSource else {self.removeStatusObservers(); return}
        
        self.multicastDelegate.invoke { (delegate) in
            delegate.resetDisplayIfNecessary(manager: self)
        }
        
        resetNowPlayingInfoCenter()
        
        if datasource.playerManagerShoulMoveToPreviousItem(manager: self){
            if let nextItemURL = datasource.playerManagerDidAskForPreviousItem(manager: self){
                self.playWithURL(url: nextItemURL)
                return
            }
            self.removeStatusObservers();
        }
    }
    
    func didFastForward(withRate:Float){
        self.kInterval = Double(withRate)/0.5
        self.player.rate = withRate
    }
    
}

//MARK: - Control Center NowPlaying

extension PlayerManager{
    
    func configureCommandCenter() {
        
        self.commandCenter.playCommand.addTarget (handler: { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let sself = self else { return .commandFailed }
            
            sself.didClickOnPlay()
            
            return .success
        })
        
        self.commandCenter.pauseCommand.addTarget (handler: { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let sself = self else { return .commandFailed }
            if sself.player.isPlaying{
                sself.didClickOnPlay()
            }
            return .success
        })
        
        self.commandCenter.nextTrackCommand.addTarget (handler: { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let sself = self else { return .commandFailed }
            sself.didClickOnNext()
            sself.updateNowPlayingInfoElapsedTime()
            return .success
        })
        
        self.commandCenter.previousTrackCommand.addTarget (handler: { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let sself = self else { return .commandFailed }
            sself.didClickOnPrevious()
            sself.updateNowPlayingInfoElapsedTime()
            return .success
        })
        
        self.commandCenter.changePlaybackPositionCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            
            if let unwrappedEvent = event as? MPChangePlaybackPositionCommandEvent{
                print(unwrappedEvent.positionTime)
                let position = unwrappedEvent.positionTime
                let playerItemDuration = self.currentPlayerItemDuration
                
              let  valued = (position * (1)/playerItemDuration.seconds)
                
                self.deinitTimeObserver()
                self.initTimeObserver()
                
                    self.scrub(value: Float(valued), minValue: 0, maxValue: 1, isSeeking: { (isSeeking) in
                        print(isSeeking)
                    })
            }
            return .success
        }

        self.commandCenter.seekForwardCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            return .success
        }
    }
    
    func updateNowPlayingInfoForCurrentPlaybackItem(){
        guard let player = self.player else {
            self.configureNowPlayingInfo(nil)
            return
        }
        
        guard let datasource = self.dataSource else {self.removeStatusObservers(); return}
        
        let unwrappedUrl = datasource.playerManagerDidAskForArtWorksImageUrl(manager: self,size: .medium)
        let titleAndAuthor = datasource.playerManagerDidAskForTrackTitleAndAuthor(manager: self)
        
        let nowPlayingInfo = [MPMediaItemPropertyTitle:titleAndAuthor.0,
                              MPMediaItemPropertyArtist:titleAndAuthor.1,
                              MPMediaItemPropertyPlaybackDuration:"\(self.currentPlayerItemDuration.seconds)",
                              MPNowPlayingInfoPropertyPlaybackRate:NSNumber(value: 1.0 as Float)] as [String : Any]// MPNowPlayingInfoPropertyIsLiveStream:NSNumber(value: true) add this to indicate live streaming
        
        
            self.downloadImage(url: unwrappedUrl, completion: { (image) -> (Void) in
                guard var nowPlayingInfo = self.nowPlayingInfo else { return }
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: CGSize(width: 100, height: 100), requestHandler: { (size) -> UIImage in
                    return image
                })
               self.configureNowPlayingInfo(nowPlayingInfo)
            })
            
        self.configureNowPlayingInfo(nowPlayingInfo as [String : AnyObject]?)
        
        self.updateNowPlayingInfoElapsedTime()
    }
    
    func downloadImage(url:URL?, completion:@escaping ((UIImage) -> (Void))){
        if let unwrappedUrl = url{
            URLSession.shared.dataTask(with: unwrappedUrl) { (data, response, error) in
                DispatchQueue.main.async {
                    if let unwrappedData = data{
                        completion(UIImage(data: unwrappedData) ?? UIImage())
                    }
                }
                
                }.resume()
        }
    }
        
    func configureNowPlayingInfo(_ nowPlayingInfo: [String: AnyObject]?) {
        self.nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        self.nowPlayingInfo = nowPlayingInfo
    }
    
    func updateNowPlayingInfoElapsedTime() {
        guard var nowPlayingInfo = self.nowPlayingInfo else { return }
        print("Player Current Time:\(self.player.currentTime().seconds)")
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = NSNumber(value: self.player.currentTime().seconds as Double);
        
        self.configureNowPlayingInfo(nowPlayingInfo)
    }
    
    func resetNowPlayingInfoCenter(){
        self.nowPlayingInfo = nil
        self.nowPlayingInfoCenter.nowPlayingInfo = nil
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

enum PlayerState:String{
    case ReadyToPlay
    case Buffering
    case Playing
    case Paused
    case Interrupted
}

