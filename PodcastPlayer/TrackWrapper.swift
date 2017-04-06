//
//  TrackWrapper.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 05/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import Soundcloud

class TrackWrapper:NSObject{
    var track:Track
    
     init(track:Track){
        self.track = track
        super.init()
    }
}
