//
//  QTGlobalInstance.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit


//Global protocol manager
@objc protocol QTGlobalProtocol{
    var playerManager:PlayerManager{
        get set
    }
}

//Global attributes manager
struct QTGlobalAttributes{
    var player:PlayerManager?
    var playerAttributes:Dictionary<String, Any>?
    
}

//Global instance of player
class QTGlobalInstance: NSObject, QTGlobalProtocol {
    internal var playerManager: PlayerManager

    
    required init(tdAttributes:QTGlobalAttributes?){
        
        guard let atAttributes = tdAttributes else{
            self.playerManager = PlayerManager.init(playerAttributes: tdAttributes?.playerAttributes)
            super.init()
            return
        }
        
        if let attributedPlayer = atAttributes.player{
            self.playerManager = attributedPlayer
        }
        else{
            self.playerManager = PlayerManager.init(playerAttributes: tdAttributes?.playerAttributes)
        }
        super.init()
    }
}
