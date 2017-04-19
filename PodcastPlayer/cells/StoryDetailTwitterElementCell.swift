//
//  StoryDetailTwitterElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/13/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype
import TwitterKit

class StoryDetailTwitterElementCell: BaseCollectionCell {
    
    var tweetView:TWTRTweetView = {
        
        let view = TWTRTweetView()
        return view
        
    }()
    
    
    //    var status:Bool = false
    
    override func setupViews() {
        super.setupViews()
        let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        view.addSubview(self.tweetView)
        self.tweetView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 15, rightConstant: 15, widthConstant: 0, heightConstant: 0)
    }
    
    
    
    override func configure(data: Any?,index:Int,status:Bool){
        super.configure(data: data)
        
        
        let card = data as? CardStoryElement
        // TODO: Base this Tweet ID on some data from elsewhere in your app
        if let twitterId = card?.metadata?.tweet_id{
            TWTRAPIClient().loadTweet(withID: (twitterId)) { (tweet, error) in
                self.tweetView.configure(with: tweet)
                if status{
                    
                    if tweet != nil{
                        let size = self.tweetView.sizeThatFits(CGSize.init(width: UIScreen.main.bounds.width - 30, height: CGFloat.greatestFiniteMagnitude))
                        self.delegate?.didCalculateSize(indexPath: index, size: CGSize(width:UIScreen.main.bounds.width,height:size.height), elementType: storyDetailLayoutType.storyDetailTwitterElementCell)
                    }else{
                        self.delegate?.didCalculateSize(indexPath: index, size: CGSize.zero, elementType: storyDetailLayoutType.storyDetailTwitterElementCell)
                    }
                }
            }
        }
        else{
            self.delegate?.didCalculateSize(indexPath: index, size: CGSize.zero, elementType: storyDetailLayoutType.storyDetailTwitterElementCell)
        }
    }
    
}
