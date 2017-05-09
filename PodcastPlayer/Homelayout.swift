//
//  Homelayout.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/3/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import Quintype
import IGListKit

final class HomeLayoutEngine:NSObject{
    var stories = [Story]()
}


enum Type {
    case Header
    case Rest
    case TextElement
    case Loader
    case RequestDedication
}

class LayoutEngine : NSObject{
    var type : Type!
    var story = Story()
    var storyElements = [CardStoryElement]()
    
    
    override init(){
        super.init()
    }
    
    init(story:Story,type:Type? = Type.Rest){
        super.init()
        self.story = story
        self.type = type
        
    }
    init(type:Type){
        super.init()
        self.type = type
    }
    
}


