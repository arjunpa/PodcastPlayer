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
            
//            let cleanString = html.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let cleanString = "स्वयं प्रोजेक्ट डेस्क लखनऊ। कामधेनु, मिनी और माइक्रो योजना के बाद अब पशुपालकों और बेरोजगार युवाओं को लाभ देने के लिए नई सरकार ने गोपालक योजना शुरू करने की पूरी तैयारी कर ली है। “नौ लाख की इस योजना का लाभ हर वर्ग के लोग उठा सकते हैं। इस योजना को छोटी रखने का यही उद्देश्य है कि इसमें लागत तो कम लगेगी साथ ही अधिक से अधिक पशुपालक इसका लाभ उठा सकेंगे। एक पशु की लागत करीब 70 हजार रुपए होगी। इस तरह प्रति इकाई की लागत सात लाख रुपए आएगी।” ऐसा बताते हैं पशुपालन विभाग के उपनिदेशक डॉ वी.के सिंह। सिंह बताते हैं, “इस योजना के तहत पशुपालक गाय-भैंस या दोनों ही रख सकेंगे। तहसील पर पशुपालक इस योजना के लिए आवेदन कर सकता हैं।” ये भी पढ़ें- जैविक खाद बेचकर आत्मनिर्भर बनीं महिलाएं वर्ष 2013 में मुख्यमंत्री अखिलेश यादव ने सवा करोड़ की कामधेनु योजना की शुरुआत की थी। इसके बाद 50 लाख मिनी और 25 लाख की माइक्रो कामधेनु डेयरी योजना शुरू की। प्रदेश में बड़ी संख्या में डेयरी के लिए आवेदन किए। लेकिन ज्यादा बजट की वजह से बड़ी संख्या में लोगों ने हाथ खड़े कर लिए। कैसे मिलेगा अनुदान पशुपालक को 7.20 लाख रुपए का बैंक ऋण दिया जाएगा, जिसे बैंक दो बार में अदा करेगी। दो बार में 5-5 पशु खरीदने होंगे। अगर कोई पशुपालक केवल पांच पशु ही रखना चाहता है तो उसे बैंक व विभाग को अवगत कराना होगा। लाभार्थी को 60 समान किस्तों में बैंक लोन व ब्याज का भुगतान करना होगा। किस्तों का भुगतान छह माह बाद शुरू करना होगा। लाभार्थी को प्रति छमाही 20 हजार रुपए का अनुदान सरकार देगी। गठित हुई समिति हर जिले में किसानों और युवाओं को लाभ देने के लिए सीडीओ की अध्यक्षता में समिति का गठन किया गया है। मुख्य पशुचिकित्साधिकारी को समिति में सचिव नामित किया गया है। इसके अलावा एक नोडल अधिकारी भी रहेंगे। जिला प्रबंधक समेत सभी तहसीलों के एसडीएम भी शामिल रहेंगे। ये भी पढ़ें- उन्नावः निकाय चुनाव के लिए वार्डों के प्रस्तावित आरक्षण की फाइल तैयार इस योजना से मार्जिन मनी की नहीं होगी दिक्कत अब तक जितनी भी योजनाएं शुरू की गई है उनमें मार्जिन मनी सबसे बड़ी समस्या रही है। कर्ज की तुलना में तय मार्जिन मनी जमा किए बिना बैंक कर्ज देते नहीं। ऐसे में सारी औपचारिकता के बाद भी कुछ पात्र कर्ज न मिलने से वंचित रह जाते हैं, लेकिन गोपालक योजना में जमीन और पशुबाड़े को ही मार्जिन मनी मान लिया जाएगा। ताजा अपडेट के लिए हमारे फेसबुक पेज को लाइक करने के लिए यहां, ट्विटर हैंडल को फॉलो करने के लिए यहां क्लिक करें। देने के लिए नई सरकार ने गोपालक योजना शुरू करने की पूरी तैयारी कर ली है। “नौ लाख की इस योजना का लाभ हर वर्ग के लोग उठा सकते हैं। इस योजना को छोटी रखने का यही उद्देश्य है कि इसमें लागत तो कम लगेगी साथ ही अधिक से अधिक पशुपालक इसका लाभ उठा सकेंगे। एक पशु की लागत करीब 70 हजार रुपए होगी। इस तरह प्रति इकाई की लागत सात लाख रुपए आएगी।” ऐसा बताते हैं पशुपालन विभाग के उपनिदेशक डॉ वी.के सिंह। सिंह बताते हैं, “इस योजना के तहत पशुपालक गाय-भैंस या दोनों ही रख सकेंगे। तहसील पर पशुपालक इस योजना के लिए आवेदन कर सकता हैं।” ये भी पढ़ें- जैविक खाद बेचकर आत्मनिर्भर बनीं महिलाएं वर्ष 2013 में मुख्यमंत्री अखिलेश यादव ने सवा करोड़ की कामधेनु योजना की शुरुआत की थी। इसके बाद 50 लाख मिनी और 25 लाख की माइक्रो कामधेनु डेयरी योजना शुरू की। प्रदेश में बड़ी संख्या में डेयरी के लिए आवेदन किए। लेकिन ज्यादा बजट की वजह से बड़ी संख्या में लोगों ने हाथ खड़े कर लिए। कैसे मिलेगा अनुदान पशुपालक को 7.20 लाख रुपए का बैंक ऋण दिया जाएगा, जिसे बैंक दो बार में अदा करेगी। दो बार में 5-5 पशु खरीदने होंगे। अगर कोई पशुपालक केवल पांच पशु ही रखना चाहता है तो उसे बैंक व विभाग को अवगत कराना होगा। लाभार्थी को 60 समान किस्तों में बैंक लोन व ब्याज का भुगतान करना होगा। किस्तों का भुगतान छह माह बाद शुरू करना होगा। लाभार्थी को प्रति छमाही 20 हजार रुपए का अनुदान सरकार देगी। गठित हुई समिति हर जिले में किसानों और युवाओं को लाभ देने के लिए सीडीओ की अध्यक्षता में समिति का गठन किया गया है। मुख्य पशुचिकित्साधिकारी को समिति में सचिव नामित किया गया है। इसके अलावा एक नोडल अधिकारी भी रहेंगे। जिला प्रबंधक समेत सभी तहसीलों के एसडीएम भी शामिल रहेंगे। ये भी पढ़ें- उन्नावः निकाय चुनाव के लिए वार्डों के प्रस्तावित आरक्षण की फाइल तैयार इस योजना से मार्जिन मनी की नहीं होगी दिक्कत अब तक जितनी भी योजनाएं शुरू की गई है उनमें मार्जिन मनी सबसे बड़ी समस्या रही है। कर्ज की तुलना में तय मार्जिन मनी जमा किए बिना बैंक कर्ज देते नहीं। ऐसे में सारी औपचारिकता के बाद भी कुछ पात्र कर्ज न मिलने से वंचित रह जाते हैं, लेकिन गोपालक योजना में जमीन और पशुबाड़े को ही मार्जिन मनी मान लिया जाएगा। ताजा अपडेट के लिए हमारे फेसबुक पेज को लाइक करने के लिए यहां, ट्विटर हैंडल को फॉलो करने के लिए यहां क्लिक करें।"
        
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
