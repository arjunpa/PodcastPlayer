//
//  TrackWrapper.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 05/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import Soundcloud
import IGListKit

class TrackWrapper:NSObject{
    var track:Track
    
     init(track:Track){
        self.track = track
        super.init()
    }
//    public func diffIdentifier() -> NSObjectProtocol{
//        return self
//    }
//    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool{
//        return isEqual(object)
//    }
}
