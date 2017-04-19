//
//  RelatedStoryElementCell.swift
//  CoreApp-iOS
//
//  Created by Albin CR on 3/15/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//


import Foundation
import UIKit
import Quintype

class RelatedStoryElementCell:BaseCollectionCell{
    
    var storyArray:[Story] = []
    
    let heightOfSingleCell:Int = 105
    
    lazy var height:CGFloat = CGFloat(self.storyArray.count * self.heightOfSingleCell)
    
    lazy var relatedStoryCollectionView:UIView = {
        
//        let view = RelatedStoryController(stories: self.storyArray)
        let view = UIView()
        return view
        
    }()
    
    
     var relatedStoryHeading:UILabel = {
       
        let label = UILabel()
        label.textColor = Themes.storyDetailCells.RelatedStoryElementCell.titleColor
        label.font = Themes.storyDetailCells.RelatedStoryElementCell.titleFont
        label.text = "Related Story"
        return label
    }()
    
    
    override func setupViews() {
        super.setupViews()
//        let view = contentView
        
        addRelatedStoryCollectionview()
        
    }
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let view = contentView
        
        if let storyArray = data as? [Story]{
            
            if storyArray.count > 0 {

                self.storyArray = storyArray
                
                view.addSubview(relatedStoryCollectionView)
                //
                relatedStoryCollectionView.anchor(relatedStoryHeading.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: self.frame.width - 30, heightConstant: height)
                
                
         
            }
        }
        
    }
    
//    override func calculateHeight(targetSize: CGSize) -> CGSize {
//        super.calculateHeight(targetSize: targetSize)
//        
//        return CGSize(width:contentView.frame.width,height:(320))
//        
//    }
    func addRelatedStoryCollectionview(){
        
        let view = contentView
//        
        view.addSubview(relatedStoryHeading)
        relatedStoryHeading.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 25)
        
        
        
        
    }
}
