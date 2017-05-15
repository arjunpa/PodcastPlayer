//
//  CircleProgressView.swift
//  customSlider
//
//  Created by Pavan Gopal on 5/14/17.
//  Copyright © 2017 Pavan Gopal. All rights reserved.
//

import Foundation
import UIKit

protocol CircleProgressViewDelegate {
    func didFinishAnimation(progressView:CircleProgressView)
}

class CircleProgressView : UIButton{
    
    var currentvalue:Double = 0
    var newToValue:Double = 0
    var isAnimationInProgress:Bool = false
    var delegate : CircleProgressViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        currentvalue = 0
        newToValue = 0
        isAnimationInProgress = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(value:Double){
        var toValue = value
        
        if value < self.currentvalue{
            return
        }else if toValue > 1{
            toValue = 1
        }
        
        if isAnimationInProgress{
            newToValue = toValue
            return
        }
        
        isAnimationInProgress = true
        
        let animationTime = toValue - self.currentvalue
        
        self.perform(#selector(self.setAnimationDone), with: nil, afterDelay: TimeInterval(animationTime))
        
        if toValue == 1 && delegate != nil{
            delegate?.didFinishAnimation(progressView: self)
        }
        
        let startAngle = 2*M_PI*self.currentvalue-M_PI_2
        let endAngle = 2*M_PI*toValue-M_PI_2
        
        let radius = 15.0 //based on buttons frame
        
        let circle = CAShapeLayer()
        
        circle.path = UIBezierPath.init(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: CGFloat(radius), startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true).cgPath
        
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor(hexString:"#f95f00").cgColor//UIColor.white.cgColor
        circle.lineWidth = 2
        
        self.layer.addSublayer(circle)
        
        let drawAimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAimation.duration = animationTime
        drawAimation.repeatCount = 0
        drawAimation.isRemovedOnCompletion = false
        
        drawAimation.fromValue = NSNumber(value: 0)
        drawAimation.toValue = NSNumber(value: 1)
        
        drawAimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        circle.add(drawAimation, forKey: "drawCircleAnimation")
        self.currentvalue = toValue
        
    }
    
    func setAnimationDone(){
        
        self.isAnimationInProgress = false
        if newToValue>self.currentvalue{
            self.setProgress(value: newToValue)
        }
    }
    
}
