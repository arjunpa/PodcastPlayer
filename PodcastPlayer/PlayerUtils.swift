//
//  PlayerUtils.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 05/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation


func formatTimeFromSeconds(seconds : Double) -> String
{
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.second, .minute, .hour]
    formatter.zeroFormattingBehavior = .pad
    let output = formatter.string(from: TimeInterval(seconds))!
    return seconds < 3600 ? output.substring(from: output.range(of: ":")!.upperBound) : output
}
