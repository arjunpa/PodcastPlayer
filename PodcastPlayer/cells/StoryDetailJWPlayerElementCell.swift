//
//  StoryDetailJWPlayerElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/13/17.
//  Copyright © 2017 Albin CR. All rights reserved.


import UIKit
import Foundation
import Quintype


class StoryDetailJWPlayerElementCell: BaseCollectionCell,JWPlayerDelegate {
    
    var player: JWPlayerController = {
        
        let view = JWPlayerController()
        return view
        
    }()
    
    var config: JWConfig = JWConfig()
    
    override func setupViews() {
        super.setupViews()
        
        let view  = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        player = JWPlayerController(config:config)
        view.addSubview(player.view)
        player.view.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 0)
 
    }
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        if let videoId = card?.metadata?.video_id{
            config.file = "http://content.jwplatform.com/videos/\(videoId).mp4"
            config.cssSkin = "http://p.jwpcdn.com/iOS/Skins/nature01/nature01.css"
            let playerWidth = self.contentView.frame.width
            let playerHeight = (9.0/16.0) * playerWidth
            player.view.frame = CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: playerWidth, height: playerHeight))
            
        }
        
    }
    
    
    override func calculateHeight(targetSize: CGSize) -> CGSize {
        let playerWidth = targetSize.width
        let playerHeight = (9.0/16.0) * playerWidth
//        player.view.frame = CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: playerWidth, height: playerHeight))
        return CGSize(width: targetSize.width, height: playerHeight + 15)

    }
    
}
