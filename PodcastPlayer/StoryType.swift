//
//  StoryType.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/3/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation


enum storyType:String{
    
    case text = "text"
    
    case jsEmbed = "jsembed"
    case audio = "audio"
    case media = "media"
    case video = "video"
    case image = "image"
    case externalFile = "external-file"
    case composite = "composite"
    case youtubePlayer = "youtube-video"
    case pollType = "polltype"
    case soundCloud = "soundcloud-audio"
    
    case title = "title"
    
    static let looper:[storyType] = [.text,.jsEmbed,.audio,.media,.video,.image,.externalFile,.composite,.youtubePlayer,.pollType,.soundCloud,.title]
    
}


enum storySubType:String{
    
    case tweet = "tweet"
    case quote = "quote"
    case summery = "summary"
    case blockquote = "blockquote"
    case blurb = "blurb"
    case bigfact = "bigfact"
    case imageGallery = "image-gallery"
    case jwPlayer = "jwplayer"
    case loaction = "loaction"
    case instagram = "instagram"
    case question = "question"
    case answer = "answer"
    case qAndA = "q-and-a"
}
