//
//  enumExtension.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 2/3/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation


//func loop<T: Hashable>(_: T.Type) -> AnyIterator<T> {
//    var i = 0
//    return AnyIterator {
//        let next = withUnsafePointer(to: &i) {
//            $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
//        }
//        if next.hashValue != i { return nil }
//        i += 1
//        return next
//    }
//}
