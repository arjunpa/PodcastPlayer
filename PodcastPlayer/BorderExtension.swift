//
//  BorderExtension.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/12/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import  UIKit

extension CALayer {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,byRoundingCorners: corners,cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        mask = shape
    }
}

extension String {
    func getWidthOfString(with font: UIFont) -> CGFloat {
        let attributes = [NSFontAttributeName : font]
        
        return NSAttributedString(string: self.capitalized, attributes: attributes).size().width
    }
    
}
