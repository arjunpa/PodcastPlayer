//
//  PlayerManager.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import AVFoundation

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
    
    var player:AVPlayer!
    
    
    var currentPlayerItemDuration:CMTime{
        get{
            if self.player.currentItem == nil{
                return kCMTimeInvalid
            }
            return self.player.currentItem!.duration
        }
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    private func commonInit(){
        player = AVPlayer.init()
    }
    
    func addObservers(){
        if self.playerItem != nil{
            self.playerItem?.removeObserver(self, forKeyPath: "status")
        }
        
        self.playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: &PlayerManager.CURRENT_ITEM_CONTEXT)
        

    }
    
    class func enableBackgroundPlay(){
        do{
          try AVAudioSession.sharedInstance().setMode(AVAudioSessionModeMoviePlayback)
        }
        catch let avError{
            print(avError)
        }
    }
    
    func initTimeObserver(){
        
        
        //make the callback fire every half seconds
        let playerDuration = self.currentPlayerItemDuration
        
        if playerDuration == kCMTimeInvalid{
            return
        }
        
        let interval = 0.5
        
        timeObserver = self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(interval), Int32(NSEC_PER_SEC)), queue: _timeObserverQueue) { (time) in
            
        }
    }
    
    
    func deinitTimeObserver(){
        if timeObserver != nil{
            self.player.removeTimeObserver(timeObserver!)
            timeObserver = nil
        }
    }
    
    func playWithURL(url:URL){
        self.addObservers()
        self.playerItem = AVPlayerItem.init(url: url)
        player.replaceCurrentItem(with: playerItem!)
    }

}

extension PlayerManager{
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


