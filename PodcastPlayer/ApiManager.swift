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
    func didloadRelatedStories(stories:[Story]?)
}

class ApiManager {
    
    weak var delegate:ApiManagerDelegate?
    
    init(delegate:ApiManagerDelegate){
        self.delegate = delegate
        
    }
    
    func getStories(offset:Int,limit:Int){
        
        DispatchQueue.global(qos: .background).async {
            Quintype.api.getStories(options: .topStories, fields: nil, offset: offset, limit: limit, storyGroup: nil, cache: .cacheToDiskWithTime(min: 10), Success: { (stories) in
                self.delegate?.didloadStories(stories: stories)
                
            }) { (errorMessage) in
                self.delegate?.handleError(message: errorMessage)
                
            }
        }
        
    }
    
    func getStoryForId(id:String){
        print(id)
        Quintype.api.getStoryFromId(storyId: id, cache: .cacheToDiskWithTime(min: 10), Success: { (story) in
            print(story)
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
    
    
    func getRelatedStory(storyId:String){
        
        Quintype.api.getRelatedStories(storyId: storyId, SectionId: nil, fields: nil, cache: cacheOption.cacheToDiskWithTime(min: 5), Success: { (storyObjectArray) in
            self.delegate?.didloadRelatedStories(stories: storyObjectArray)
        }) { (error) in
            
        }
    }
}

extension ApiManagerDelegate{
    func didloadStory(story:Story?){}
    func didloadStories(stories:[Story]?){}
    func handleError(message:String?){}
    func didloadRelatedStories(stories:[Story]?){}
}
