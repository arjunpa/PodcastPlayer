//
//  MulticastDelegate.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 07/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit


class MulticastDelegate<T>: NSObject {
    
    private var weakDelegates:NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    func addDelegate(delegate:T){
        
        weakDelegates.add(delegate as AnyObject?)
    }
    
    func removeDelegate(delegate:T){
        if weakDelegates.contains(delegate as AnyObject?){
            weakDelegates.remove(delegate as AnyObject?)
        }
    }
    
    
    func invoke(invokation:(T) -> ()){
        let enumerator = self.weakDelegates.objectEnumerator()
        
        while let delegate: AnyObject = enumerator.nextObject() as AnyObject? {
            invokation(delegate as! T)
        }
    }
}
