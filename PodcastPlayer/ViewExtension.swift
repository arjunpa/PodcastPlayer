//
//  ViewExtension.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/5/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation

extension UIView{
  
    func applyGradient(colors:[UIColor],locations:[NSNumber]?,startPoint:CGPoint,endPoint:CGPoint){
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map({$0.cgColor})
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
