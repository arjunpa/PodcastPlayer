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
            
            let cleanString = html.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
            let data:Data? = cleanString.data(using: String.Encoding.utf8)
            
            let attrString:NSAttributedString = NSAttributedString.init(htmlData: data!, options: options, documentAttributes: nil)
            
            
            let mutableString = attrString.mutableCopy() as? NSMutableAttributedString
            
            let charSet = CharacterSet.whitespacesAndNewlines
            
            var someString = (mutableString?.string)! as NSString
            
            var range  = someString.rangeOfCharacter(from: charSet)
            
            while (range.length != 0 && range.location == 0)
            {
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
    
    func convertAndReturn(toHtml html:String,textOption:textOption) -> NSMutableAttributedString{
        
        let options = textOption.value
        
        let cleanString = html.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let data:Data? = cleanString.data(using: String.Encoding.utf8)
        
        let attrString:NSAttributedString = NSAttributedString.init(htmlData: data!, options: options, documentAttributes: nil)
        
        
        let mutableString = attrString.mutableCopy() as? NSMutableAttributedString
        
        let charSet = CharacterSet.whitespacesAndNewlines
        
        var someString = (mutableString?.string)! as NSString
        
        var range  = someString.rangeOfCharacter(from: charSet)
        
        while (range.length != 0 && range.location == 0)
        {
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
        
        self.attributedText = mutableString!
        return  mutableString!
        
    }
}

public enum textOption {
    
    case html
    case blockquote
    case quote
    case blurb
    case question
    case answer
    
    var value: [String : Any] {
        
        get{
            switch self {
                
            case .html:
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.storyHtmlTextFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.storyHtmlTextFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.storyHtmlTextFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.storyHtmlTextColor,
                    DTDefaultLinkColor:ThemeService.shared.theme.storyHtmlHyperLinkTextColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    
                    ]
                
                return html
                
            case .blockquote:
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.blockquoteElementFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.blockquoteElementFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.blockquoteElementFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.blockQuoteElementColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    ]
                return html
                
            case .quote:
                
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.storyHtmlTextFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.storyHtmlTextFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.storyHtmlTextFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.storyHtmlTextColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    
                    ]
                return html
                
            case .blurb:
                
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.blurbElementFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.blurbElementFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.blurbElementFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.blurbElementColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    
                    ]
                return html
                
            case .question:
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.questionElementFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.questionElementFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.questionElementFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.questionElementColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    
                    ]
                return html
                
            case .answer:
                let html:[String : Any?] = [
                    
                    DTUseiOS6Attributes:NSNumber.init(value: true),
                    DTDefaultFontFamily:ThemeService.shared.theme.answerElementFont.familyName,
                    DTDefaultFontName:ThemeService.shared.theme.answerElementFont.fontName,
                    DTDefaultFontSize:ThemeService.shared.theme.answerElementFont.pointSize,
                    DTDefaultTextColor:ThemeService.shared.theme.answerElementColor,
                    DTDefaultLinkDecoration:"#D9241C",
                    DTDefaultTextAlignment:"",
                    DTDefaultLineHeightMultiplier:"1.2",
                    ]
                
                return html
            }
        }
        
        
    }
    
}
