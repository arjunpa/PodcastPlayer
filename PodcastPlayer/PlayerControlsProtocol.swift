//
//  PlayerControlsProtocol.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 04/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import UIKit
protocol PlayerControlActionProtocol:class{
    func didClickOnPlay(control:PlayerControlActionProtocol,isPlaying playingValue:@escaping (Bool) -> ())
    func didClickOnNext(control:PlayerControlActionProtocol)
    func didClickOnPrev(control:PlayerControlActionProtocol)
    func beginScrubbing()
    func endScrubbing()
    func scrub(isSeeking seekValue:@escaping (Bool) -> ())
}

protocol PlayerControlsSourceProtocol:class {
    static func loadFromNib() -> PlayerControlsSourceProtocol
    func sizeFit() -> CGSize
    weak var controlDelegate:PlayerControlActionProtocol?{
        set get
    }
}
