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
    func didClickOnPlay(control:PlayerControlActionProtocol)
    func didClickOnNext(control:PlayerControlActionProtocol)
    func didClickOnPrev(control:PlayerControlActionProtocol)
}

protocol PlayerControlsSourceProtocol:class {
    static func loadFromNib() -> PlayerControlsSourceProtocol
    func sizeFit() -> CGSize
    weak var controlDelegate:PlayerControlActionProtocol?{
        set get
    }
}
