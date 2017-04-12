//
//  HtmlRender.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/2/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import UIKit
import DTCoreText
import DTFoundation

extension UITextView{
    
    func convert(toHtml html:String,textOption:textOption){
        
        let options = textOption.value
        let data: Data? = html.data(using: String.Encoding.utf8)
        let attrString:NSAttributedString = NSAttributedString.init(htmlData: data!, options: options, documentAttributes: nil)
        
        
        let mutableString = attrString.mutableCopy() as? NSMutableAttributedString
        
        let charSet = CharacterSet.whitespacesAndNewlines
        
        var someString = (mutableString?.string)! as NSString
        
        var range  = someString.rangeOfCharacter(from: charSet)
        
        while (range.length != 0 && range.location == 0)
        {
            // [attString replaceCharactersInRange:range
            //   withString:@""];
            mutableString?.replaceCharacters(in: range, with: "")
            someString = (mutableString?.string)! as NSString
            range = someString.rangeOfCharacter(from: charSet)
            
        }
        
        
        range = someString.rangeOfCharacter(from: charSet, options: .backwards)
        
        while (range.length != 0 && NSMaxRange(range) == someString.length)
        {
            
            mutableString?.replaceCharacters(in: range, with: "")
            someString = (mutableString?.string)! as NSString
            range = someString.rangeOfCharacter(from: charSet, options: .backwards)
        }
        
        self.attributedText = mutableString
    }
}

public enum textOption {
    
    case html
    
    var value: [String : Any] {
        
        switch self {
            
        case .html:
            var html:[String : Any?] = [
                
                DTUseiOS6Attributes:NSNumber.init(value: true),
                DTDefaultFontFamily:"Merriweather",
                DTDefaultFontName:"Merriweather-Light",
                DTDefaultFontSize:"16",
                DTDefaultTextColor:UIColor.black,
                DTDefaultLinkColor:"#D9241C",
                DTDefaultLinkDecoration:"#D9241C",
                DTDefaultLinkHighlightColor:"#D9241C",
                DTDefaultTextAlignment:"",
                DTDefaultLineHeightMultiplier:"1.2",
                
                ]
            
            return html
            
        }
    }
}
