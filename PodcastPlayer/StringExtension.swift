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
    
//    var localizedString: String{
//        get{
//            return LocalizationHelper.sharedHelper.localizedStringForKey(self)
//        }
//    }
    
}

