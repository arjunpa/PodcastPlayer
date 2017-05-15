//
//  CustomSlider.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/14/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = 5
        return newBounds
    }
 
       func setGradientToSlider(colors:[UIColor]){
        
        let view = self.subviews[0]
        let maxTrackImageView = view.subviews[0]
        
        //setting gradient to maxTrack imageview
/*
        let maxTrackGradient = CAGradientLayer()
        
        var MaxRect = maxTrackImageView.frame
        MaxRect.origin.x = view.frame.origin.x
        
        maxTrackGradient.frame = MaxRect
        maxTrackGradient.colors = colors
        
        maxTrackGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        maxTrackGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        view.layer.cornerRadius = 5
        maxTrackImageView.layer.insertSublayer(maxTrackGradient, at: 0)
*/
        
        //setting gradient to min track imageview
        
        let minTrackGradient = CAGradientLayer()
        let minTrackImageView = self.subviews[1] // view.subviews[1]
        
        var rect = minTrackImageView.frame
            
        rect.size.width = maxTrackImageView.frame.size.width
        rect.origin.y = 0
        rect.origin.x = 0
        
        minTrackGradient.frame = rect
        minTrackGradient.colors = colors
        
        minTrackGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        minTrackGradient.endPoint = CGPoint(x: 1,y: 0.5)
        minTrackImageView.layer.cornerRadius = 5
        minTrackImageView.layer.insertSublayer(minTrackGradient, at: 0)
        
    }
    
    override var alignmentRectInsets : UIEdgeInsets {
        return UIEdgeInsetsMake(4.0, 2.0, 4.0, 2.0)
    }
    
}
