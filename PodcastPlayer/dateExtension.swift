//
//  dateExtension.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/12/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation


extension NSNumber{
    
    var convertTimeStampToDate:String?{
        
        let dateTimeStamp = NSDate(timeIntervalSince1970:Double(self)/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.dateFormat =  "MMM dd ',' yyyy"
        let result = dateFormatter.string(from: dateTimeStamp as Date)
        return result
    }
}


