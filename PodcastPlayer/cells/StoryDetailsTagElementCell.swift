//
//  StoryDetailstagElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import UIKit
import Quintype

class StoryDetailsTagElementCell: BaseCollectionCell {
    
    let screenWidth:CGFloat = UIScreen.main.bounds.width - 20
    var usableWidth:CGFloat = 0
    var yPos:CGFloat =  15
    var xPos:CGFloat = 15
    let buttonSpacing:CGFloat = 10
    let totalButtonInset:CGFloat = 10
    let tagButtonHeight:CGFloat = 30
    let buttonBorderWidth:CGFloat = 3
    
    var tagLabel:UILabel = {
        
        let label = UILabel()
        label.backgroundColor = Themes.storyDetailCells.storyDetailsTagElementCell.tagButtonBackgroundColor
        return label
        
    }()

    
    var tags:[Tag] = []
    
    var created:Bool = false
    
    override func configure(data: Any?) {
        
        let story = data as? Story
        
       //print(created)
        
        if !created {
            if let tags = story?.tags{
                self.tags = tags
            }
            
            setupViews()
            created = true
        }
        
    }
    
    
    
    func layoutTags(index:Int,button:UIButton,tag:String){
        
        let view = self.contentView
        
        let buttonWidth = tag.getWidthOfString(with: UIFont.systemFont(ofSize: 12))  + totalButtonInset + buttonBorderWidth + 10
        
        if index == tags.count - 1{
            
            view.addSubview(button)
            
            let topConstrain = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: yPos)
            
            let letfConstrain = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: xPos)
            
            let bottomConstrain  = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -20)
            
            let widthConstarin = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: buttonWidth)
            
            let heightConstarin = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: tagButtonHeight)
            
            
            view.addConstraints([topConstrain,letfConstrain,bottomConstrain,widthConstarin,heightConstarin])
            
            
        }else{
            
            view.addSubview(button)
            
            let topConstrain = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: yPos)
            
            let letfConstrain = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: xPos)
            
            let widthConstarin = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: buttonWidth)
            
            let heightConstarin = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: tagButtonHeight)
            
            view.addConstraints([topConstrain,letfConstrain,widthConstarin,heightConstarin])
            
        }
    }
    
    override func setupViews() {
        
        let view = self.contentView
        view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)

        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        let verticalButtonSpacing = tagButtonHeight + buttonSpacing
        var totalViewHeight:CGFloat = verticalButtonSpacing
        
        for (index,tag) in tags.enumerated(){
            
            let buttonWidth = (tag.name?.getWidthOfString(with: UIFont.systemFont(ofSize:12)))! + totalButtonInset + buttonBorderWidth + 5
            let button = UIButton()
            
            button.titleEdgeInsets = Themes.storyDetailCells.storyDetailsTagElementCell.tagButtonPadding
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(tag.name?.lowercased(), for: .normal)
            button.titleLabel?.font = Themes.storyDetailCells.storyDetailsTagElementCell.tagButtonFontSize
            button.tag = index
            button.backgroundColor = Themes.storyDetailCells.storyDetailsTagElementCell.tagButtonBackgroundColor
            button.layer.borderWidth = Themes.storyDetailCells.storyDetailsTagElementCell.tagButtonBorderWidth
            button.layer.borderColor = Themes.storyDetailCells.storyDetailsTagElementCell.tagButtonBorderColor
            button.setTitleColor(Themes.storyDetailCells.storyDetailsTagElementCell.tagButtonFontColor, for: UIControlState.normal)
            button.layer.cornerRadius = Themes.storyDetailCells.storyDetailsTagElementCell.tabButtonRadius
            button.addTarget(self, action: #selector(tagButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            button.isUserInteractionEnabled = true
            if (usableWidth < screenWidth) && (usableWidth + buttonWidth < screenWidth) {
                
                usableWidth = usableWidth + buttonWidth + buttonSpacing
                layoutTags(index: index, button: button, tag: tag.name!)
                xPos = xPos + buttonWidth + buttonSpacing
                
            }else{
                
                totalViewHeight = totalViewHeight + verticalButtonSpacing
                usableWidth = buttonWidth + buttonSpacing
                yPos =  yPos + tagButtonHeight + buttonSpacing
                xPos = 15
                layoutTags(index: index, button: button, tag: tag.name!)
                xPos = xPos + buttonWidth + buttonSpacing
                
            }
        }
        
    }
    
    
    
    func tagButtonAction(sender:UIButton){
        
//        if let tabBarController = self.window?.rootViewController as? TabBarController{
//            
//            if let navigationController = tabBarController.selectedViewController as? UINavigationController{
//                
//                if let tag = tags[sender.tag].name{
//                    let tagPageController = PagerController.init(tag: tag)
//                    navigationController.pushViewController(tagPageController, animated: true)
//                }
//            }
//            
//        }
        
    }
    
    
}
