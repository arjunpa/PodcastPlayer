//
//  StringExtension.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/9/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation

extension String {
    
    func decodeBase64() -> String? {
        guard let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    
}

extension String {
    func getWidthOfString(with font: UIFont) -> CGFloat {
        let attributes = [NSFontAttributeName : font]
        
        return NSAttributedString(string: self.capitalized, attributes: attributes).size().width
    }
    
    func getHeightOfString(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
