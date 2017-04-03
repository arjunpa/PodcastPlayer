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
    var player:AVPlayer!
    override init() {
        super.init()
        commonInit()
    }
    
    private func commonInit(){
        player = AVPlayer.init()
    }
    
    func addObservers(){
        self.player.addObserver(self, forKeyPath: "currentItem", options: .new, context: &PlayerManager.CURRENT_ITEM_CONTEXT)
    }
    
    func playWithURL(url:URL){
        let item = AVPlayerItem.init(url: url)
        player.replaceCurrentItem(with: item)
      
    }

}

/*
 
    Really, anything that goes about observing the player state should go here. I mean, DO IT.
 */

extension PlayerManager{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath ?? "" == "currentItem")  && context == &PlayerManager.CURRENT_ITEM_CONTEXT{
            if player.status == AVPlayerStatus.readyToPlay{
                player.play()
            }
        }
        else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}


