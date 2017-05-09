//
//  StoryDetailSocialShareCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailSocialShareElementCell: BaseCollectionCell {
    
    let authorName:UIButton = {
        
        let button = UIButton()
        button.setTitleColor(Themes.storyDetailCells.storyDetailSocialShareElementCell.autherFontColor, for: UIControlState.normal)
        button.titleLabel?.font = Themes.storyDetailCells.storyDetailSocialShareElementCell.autherFontSize
        return button
        
    }()
    
    let sepratorLine:UIView = {
       
        let view = UIView()
        view.backgroundColor = Themes.storyDetailCells.storyDetailSocialShareElementCell.separatorBarColor
        return view
        
    }()
    
    let authorNameSeprator:UIView = {
        
        let view = UIView()
        view.backgroundColor = Themes.storyDetailCells.storyDetailSocialShareElementCell.separatorBarColor
        return view
        
    }()
    
    let publishedDate:UILabel = {
        
        let label = UILabel()
        label.textColor = Themes.storyDetailCells.storyDetailSocialShareElementCell.publishedDataFontColor
        label.font = Themes.storyDetailCells.storyDetailSocialShareElementCell.publishedDataFontSize
        return label
        
    }()

    let facebookShareIcon:UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named:"video"), for: UIControlState.normal)
        return button
        
        
    }()
    
    let shareButton:UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named:"share"), for: UIControlState.normal)
        button.tintColor = Themes.storyDetailCells.storyDetailSocialShareElementCell.shareButtonColor
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
        
    }()
    
    let commentButton:UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named:"comments"), for: UIControlState.normal)
        button.tintColor = Themes.storyDetailCells.storyDetailSocialShareElementCell.shareButtonColor
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
        
    }()
    
    let twitterShareIcon:UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named:"video"), for: UIControlState.normal)
        return button
        
    }()
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let data = data as? Story
        
        if let autherName = data?.author_name{

            authorName.setTitle(autherName, for: UIControlState.normal)
        }
        
        if let publishedAt = data?.published_at?.convertTimeStampToDate{
            publishedDate.text = "\(publishedAt)"
        }
        
        //TODO: - add facebook and twitter icon
        
        
    }
    
    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        view.addSubview(authorName)
        view.addSubview(authorNameSeprator)
        view.addSubview(publishedDate)
        view.addSubview(shareButton)
        view.addSubview(commentButton)
        view.addSubview(sepratorLine)
        
        authorName.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
        
        authorNameSeprator.anchor(view.topAnchor, left: authorName.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0.5, heightConstant: 18)
        
        publishedDate.anchor(view.topAnchor, left: authorNameSeprator.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        commentButton.anchor(publishedDate.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        shareButton.anchor(commentButton.topAnchor, left: commentButton.rightAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        
        sepratorLine.anchor(commentButton.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 0.5)

    }
    
    
    
}
