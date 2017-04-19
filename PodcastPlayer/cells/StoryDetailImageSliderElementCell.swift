//
//  StoryDetailImageSliderElementCell.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/1/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//
//TODO - imageDisplayType
import Foundation
import UIKit
import Quintype

class MetaImage{
    
    var imageMeta:ImageMetaData?
    var image:String?
    var imageDescription:String?
    
    
}

enum imageDisplayType:String{
    
    case slideshow = "slideshow"
    case gallery = "gallery"
    
}

class StoryDetailImageSliderElementCell:BaseCollectionCell,CAAnimationDelegate{
    
    
    var _imageViewHeightConstraint:NSLayoutConstraint?
    var imageViewHeightConstraint:NSLayoutConstraint{
        get{
            if _imageViewHeightConstraint != nil{
                self.imageSlider.removeConstraint(_imageViewHeightConstraint!)
                
            }
            
            self._imageViewHeightConstraint = NSLayoutConstraint.init(item: self.imageSlider, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
            self._imageViewHeightConstraint!.priority = 999
            self.imageSlider.addConstraint(_imageViewHeightConstraint!)
            return _imageViewHeightConstraint!
        }
        set{
            self._imageViewHeightConstraint = newValue
        }
    }
    
    
    func calculateImageSize(metadata:ImageMetaData?) -> CGSize{
        let widthDimension2 = UIScreen.main.bounds.size.width
        guard metadata != nil else {
            return CGSize.init(width: widthDimension2, height: widthDimension2 * 3.0/4.0)
        }
        
        if let width = metadata?.width, metadata!.height != nil{
            let widthDimenstion1 = CGFloat(width.floatValue)
            let heightDimension1 = CGFloat((metadata?.height!.floatValue)!)
            
            
            let heightDimenstion2 = widthDimension2 * heightDimension1/widthDimenstion1
            return CGSize.init(width: widthDimension2, height: heightDimenstion2)
        }
        
        
        return CGSize.init(width: widthDimension2, height: widthDimension2 * 3.0/4.0)
    }
    
    
    
    let imageBaseUrl = "http://" + (Quintype.publisherConfig?.cdn_image)! + "/"
    
    let screenWidth = UIScreen.main.bounds.width
    
    var imageArray:[MetaImage] = []
    
    var imageCounter = 0
    
    var imageSlider:UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        return imageView
        
    }()
    
    var rightButtonBackgroundLayer:UIView = {
        
        let view = UIView()
        view.backgroundColor = Themes.storyDetailCells.storyDetailImageSliderElementCell.imageSliderRightButtonBackgroungColor.withAlphaComponent(Themes.storyDetailCells.storyDetailImageSliderElementCell.imageSliderButtonBackgroundLayerOpacity)
        return  view
        
    }()
    
    var rightSliderButton:UIButton = {
        
        let button = UIButton()
        button.setImage( Themes.storyDetailCells.storyDetailImageSliderElementCell.imageSliderRightButtonImage, for: UIControlState.normal)
        button.tintColor =  Themes.storyDetailCells.storyDetailImageSliderElementCell.arrowButtonIconColor
        return button
        
    }()
    
    var leftButtonBackgroundLayer:UIView = {
        
        let view = UIView()
        view.backgroundColor = Themes.storyDetailCells.storyDetailImageSliderElementCell.imageSliderRightButtonBackgroungColor.withAlphaComponent(Themes.storyDetailCells.storyDetailImageSliderElementCell.imageSliderButtonBackgroundLayerOpacity)
        return  view
        
    }()
    
    var leftSliderButton:UIButton = {
        
        let button = UIButton()
        button.setImage( Themes.storyDetailCells.storyDetailImageSliderElementCell.imageSliderLeftButtonImage, for: UIControlState.normal)
        button.tintColor =  Themes.storyDetailCells.storyDetailImageSliderElementCell.arrowButtonIconColor
        return button
        
    }()
    
    
    let imageTextDescriptionLayer:UIView = {
        
        let view = UIView()
        view.backgroundColor =  Themes.storyDetailCells.storyDetailImageSliderElementCell.imageDescriptionLayerColor
        view.alpha = Themes.storyDetailCells.storyDetailImageSliderElementCell.imageDescriptionLayerOpacity
        return  view
        
    }()
    
    var imageTextDescription:UILabel = {
        
        let label = UILabel()
        label.font =  Themes.storyDetailCells.storyDetailImageSliderElementCell.imageDescriptionFontSize
        label.textColor = Themes.storyDetailCells.storyDetailImageSliderElementCell.imageDescriptionFontColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
        
    }()

    
    override func setupViews() {
        super.setupViews()
        
         let view = self.contentView
view.backgroundColor = readThemeColorPlist(colorName: colors.defaultCellBackgroundColor.rawValue)
        
        
        view.addSubview(imageSlider)
        view.addSubview(leftButtonBackgroundLayer)
        leftButtonBackgroundLayer.addSubview(leftSliderButton)
        view.addSubview(rightButtonBackgroundLayer)
        rightButtonBackgroundLayer.addSubview(rightSliderButton)
        imageSlider.addSubview(imageTextDescriptionLayer)
        imageSlider.addSubview(imageTextDescription)
        
        imageSlider.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant:screenWidth , heightConstant: 0)
        
        leftButtonBackgroundLayer.anchor(nil, left: nil, bottom: nil, right: imageSlider.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 60)
        leftButtonBackgroundLayer.anchorCenterYToSuperview()
        
        leftSliderButton.anchorCenterXToSuperview()
        leftSliderButton.anchorCenterYToSuperview()
        leftSliderButton.addTarget(self, action: #selector(StoryDetailImageSliderElementCell.swipeLeft(sender:)), for: UIControlEvents.touchUpInside)
        
        rightButtonBackgroundLayer.anchor(nil, left: imageSlider.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 60)
        rightButtonBackgroundLayer.anchorCenterYToSuperview()
        
        rightSliderButton.anchorCenterXToSuperview()
        rightSliderButton.anchorCenterYToSuperview()
        rightSliderButton.addTarget(self, action: #selector(StoryDetailImageSliderElementCell.swipeRight(sender:)), for: UIControlEvents.touchUpInside)
        
        imageTextDescriptionLayer.anchor(nil, left: imageSlider.leftAnchor, bottom: imageSlider.bottomAnchor, right: imageSlider.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        
        imageTextDescription.anchor(nil, left: imageSlider.leftAnchor, bottom: imageSlider.bottomAnchor, right: imageSlider.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 5, rightConstant: 15, widthConstant: 0, heightConstant: 0)
        
        //        let tapGestureReconizerObject=UITapGestureRecognizer(target: self, action: #selector(StoryDetailImageSliderElementCell.swipeImage(sender:)))
        //        imageSlider.addGestureRecognizer(tapGestureReconizerObject)
        
    }
    
    func UIAnimationforNextPage() {
        var transition: CATransition? = nil
        transition = CATransition()
        transition!.duration = 0.5
        transition!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition!.type = kCATransitionPush
        transition!.subtype = kCATransitionFromRight
        transition!.delegate = self
        imageSlider.layer.add(transition!, forKey: nil)
    }
    
    func UIAnimationforPreviousPage() {
        var transition: CATransition? = nil
        transition = CATransition()
        transition!.duration = 0.5
        transition!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition!.type = kCATransitionPush
        transition!.subtype = kCATransitionFromLeft
        transition!.delegate = self
        imageSlider.layer.add(transition!, forKey: nil)
    }
    
    
    //    func swipeImage(sender:AnyObject){
    //
    //        if (sender.direction == .right){
    //
    //            imageCounter = imageCounter - 1
    //            let currentImage =  imageArray[imageCounter % imageArray.count]
    //            imageSlider.loadImage(url: currentImage, targetSize: CGSize(width: imageSlider.frame.width, height: imageSlider.frame.height))
    //            UIAnimationforPreviousPage()
    //
    //
    //        }else if (sender.direction == .left){
    //
    //            imageCounter = imageCounter + 1
    //            let currentImage =  imageArray[imageCounter % imageArray.count]
    //            imageSlider.loadImage(url: currentImage, targetSize: CGSize(width: imageSlider.frame.width, height: imageSlider.frame.height))
    //            UIAnimationforNextPage()
    //        }
    //
    //
    //
    //    }
    
    
    func swipeLeft(sender:AnyObject){
        
        imageCounter = imageCounter + 1
        
        if let currentImage = imageArray[imageCounter % imageArray.count].image{
            imageSlider.loadImage(url: imageBaseUrl + currentImage,  targetSize: CGSize(width: imageSlider.frame.width, height: imageSlider.frame.height),imageMetaData: imageArray[imageCounter % imageArray.count].imageMeta!)        }
        
        if let currentImageText = imageArray[imageCounter % imageArray.count].imageDescription{
            
            self.imageTextDescription.text = currentImageText
            
        }
        
        
        UIAnimationforNextPage()
        
    }
    
    func swipeRight(sender:AnyObject){
        
        if (imageCounter - 1) <= 0{
            imageCounter = imageArray.count
        }else{
            imageCounter = imageCounter - 1
        }
        
        
        
        if let currentImage = imageArray[imageCounter % imageArray.count].image{
            imageSlider.loadImage(url: imageBaseUrl + currentImage, targetSize: CGSize(width: imageSlider.frame.width, height: imageSlider.frame.height),imageMetaData: imageArray[imageCounter % imageArray.count].imageMeta!)
        }
        
        if let currentImageText = imageArray[imageCounter % imageArray.count].imageDescription{
            
            self.imageTextDescription.text = currentImageText
        }
        
        UIAnimationforPreviousPage()
        
    }
    
    override func configure(data: Any?) {
        super.configure(data: data)
        
        let card = data as? CardStoryElement
        
        
        if card?.metadata?.type == imageDisplayType.gallery.rawValue{
            
            
            
        }else{
            
            
            
        }
        
        
        
        for (_,card) in (card?.story_elements.enumerated())!{
            
            let imageDataHolder = MetaImage()
            imageDataHolder.image = card.image_s3_key
            imageDataHolder.imageMeta = card.image_metadata
            imageDataHolder.imageDescription = card.title
            imageArray.append(imageDataHolder)
            
        }
        
        //        DispatchQueue.main.async {
        
        if let image = self.imageArray[0].image{
            
            let imageSize = self.calculateImageSize(metadata: card?.hero_image_metadata)
            
            self.imageViewHeightConstraint.constant = imageSize.height
            
            self.imageSlider.loadImage(url: imageBaseUrl + image + "?w=\(imageSize.width)", targetSize: CGSize(width: imageSlider.frame.width, height: imageSlider.frame.height),imageMetaData: imageArray[imageCounter % imageArray.count].imageMeta!)
            
        }
        
        if let imageDescription = self.imageArray[0].imageDescription{
            
            self.imageTextDescription.text = imageDescription
        }
        
        //    }
    }
    
}
