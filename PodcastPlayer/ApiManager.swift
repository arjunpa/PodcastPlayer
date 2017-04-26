//
//  ApiManager.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import Quintype

 protocol ApiManagerDelegate:class {
    func didloadStories(stories:[Story]?)
    func handleError(message:String?)
    func didloadStory(story:Story?)
}

class ApiManager {
    
    weak var delegate:ApiManagerDelegate?

    init(delegate:ApiManagerDelegate){
        self.delegate = delegate
        
    }
    
    func getStories(offset:Int,limit:Int){
        Quintype.api.getStories(options: .topStories, fields: nil, offset: offset, limit: 10, storyGroup: nil, cache: .cacheToDiskWithTime(min: 10), Success: { (stories) in
            self.delegate?.didloadStories(stories: stories)
            
        }) { (errorMessage) in
            self.delegate?.handleError(message: errorMessage)
            
        }
    }
    
    func getStoryForId(id:String){
        Quintype.api.getStoryFromId(storyId: id, cache: .cacheToDiskWithTime(min: 10), Success: { (story) in
            self.delegate?.didloadStory(story: story)
        }){(errorMessage) in
            self.delegate?.handleError(message: errorMessage)
        }
    }
    
    
    func getStoriesBySection(sectionName:String,offset:Int,limit:Int){
            Quintype.api.getStories(options: .section(sectionName: sectionName), fields: nil, offset: offset, limit: limit, storyGroup: nil, cache: .cacheToDiskWithTime(min: 10), Success: { (stories) in
                self.delegate?.didloadStories(stories: stories)
            }) { (errorMessage) in
                self.delegate?.handleError(message: errorMessage)
        }
    }
    
    func getStoriesWithSearchString(text:String,offset:Int,limit:Int){
        Quintype.api.search(searchBy: .key(string: text), fields: nil, offset: offset, limit: limit, cache: .cacheToDiskWithTime(min: 10), Success: { (data) in
            self.delegate?.didloadStories(stories: data?.stories)
        }) { (errorMessage) in
            self.delegate?.handleError(message: errorMessage)
        }
    }
}

extension ApiManagerDelegate{
    func didloadStory(story:Story?){}
    func didloadStories(stories:[Story]?){}
    func handleError(message:String?){}
}
