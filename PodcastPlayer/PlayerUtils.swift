//
//  PlayerUtils.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 05/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation


func formatTimeFromSeconds(seconds:Double) -> String{
    let date = Date.init(timeIntervalSinceReferenceDate: seconds)
    let formatter:DateFormatter = DateFormatter.init()
    formatter.dateFormat = "HH:mm:ss"
    formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
    return formatter.string(from: date)
}
