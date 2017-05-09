//
//  StoryDetailLayoutEngine.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//



import Foundation
import Quintype

public struct constantCells{
    
    static var topStoryDetailsCells:[storyDetailLayoutType] = [.storyDetailHeaderImageElementCell,.storyDetailHeaderTextElementCell]//.storyDetailSocialShareElementCellr
    static var bottomStoryDetailsCells:[storyDetailLayoutType] = [.storyDetailCommentElementCell]//.storyDetailsTagElementCell,
    
}

class StoryDetailLayoutEngine{
    
    var story:Story?
    var layoutEngineArray:[StoryDetailLayout] = []
    
    
    public init(story:Story){
        
        self.story = story
    }
    
    func makeLayouts(completion:@escaping (_ layouts:[StoryDetailLayout]) -> Void){
        
        let constantCellArray:[storyDetailLayoutType] = constantCells.topStoryDetailsCells
        let bottomCellArray:[storyDetailLayoutType] = constantCells.bottomStoryDetailsCells
        
        
        
        //Initial static cells
        for (_,cell) in constantCellArray.enumerated(){
            var layoutArray:StoryDetailLayout!
            
            layoutArray = StoryDetailLayout(layoutType: cell)
            layoutEngineArray.append(layoutArray)
        }
        
        // dynamic cells
        if let story = story{
            print("Cards Count:\(story.cards.count)")
            for (_,card) in story.cards.enumerated(){
                print("Story Elements Count :\(card.story_elements.count) ")
                for (_,storyElement) in card.story_elements.enumerated(){
                    //                    print("Story Elements Count :\(card.story_elements.count) ")
                    
                    storyElementMapper(storyElement:storyElement)
                }
            }
            
        }
        
        //Bottom static cells
        
        for (_,cell) in bottomCellArray.enumerated(){
            var layoutArray:StoryDetailLayout!
            
            layoutArray = StoryDetailLayout(layoutType: cell)
            layoutEngineArray.append(layoutArray)
        }
        
        
        completion(layoutEngineArray)
        
    }
    
    func storyElementMapper(storyElement:CardStoryElement){
        
        
        
        for type in storyType.looper where type.rawValue == storyElement.type{
            
            switch storyElement.subtype{
                
            case storySubType.bigfact.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailBigFactElementCell,storyElement:storyElement)
                break
                
            case storySubType.blockquote.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailBlockkQuoteElementCell,storyElement:storyElement)
                
            case storySubType.blurb.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailBlurbElementCell,storyElement:storyElement)
                break
                
            case storySubType.imageGallery.rawValue?:
                createCell(cell: storyDetailLayoutType.galleryElementCell,storyElement:storyElement)
                break
                
            case storySubType.instagram.rawValue?:
                //                createCell(cell: storyDetailLayoutType.instagram)
                createCell(cell: storyDetailLayoutType.storyDetailJsEmbbedElementCell,storyElement:storyElement)
                break
                
            case storySubType.jwPlayer.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailJWPlayerElementCell,storyElement:storyElement)
                
                break
                
            case storySubType.loaction.rawValue?:
                //                createCell(cell: storyDetailLayoutType.location)
                createCell(cell: storyDetailLayoutType.storyDetailJsEmbbedElementCell,storyElement:storyElement)
                break
                
            case storySubType.question.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailQuestionElementCell,storyElement:storyElement)
                break
                
            case storySubType.answer.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailAnswerElementCell,storyElement:storyElement)
                break
                
            case storySubType.quote.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailQuoteElementCell,storyElement:storyElement)
                break
                
            case storySubType.summery.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailSummeryElementCell,storyElement:storyElement)
                break
                
            case storySubType.tweet.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailTwitterElementCell,storyElement:storyElement)
                //                createCell(cell: storyDetailLayoutType.tweet)
                break
                
            case storySubType.qAndA.rawValue?:
                createCell(cell: storyDetailLayoutType.storyDetailQandACell, storyElement: storyElement)
                break
                
            case nil:
                //print(type.rawValue)
                
                
                switch type.rawValue{
                    
                case storyType.image.rawValue:
                    createCell(cell: storyDetailLayoutType.storyDetailImageElementCell,storyElement:storyElement)
                    break
                case storyType.soundCloud.rawValue:
                    //                    createCell(cell: storyDetailLayoutType.soundcloud)
                    break
                case storyType.audio.rawValue:
                    //                    createCell(cell: storyDetailLayoutType.audio)
                    break
                case storyType.composite.rawValue:
                    //                    createCell(cell: storyDetailLayoutType.composit) // do not exist
                    break
                case storyType.externalFile.rawValue:
                    //                    createCell(cell: storyDetailLayoutType.externalfile)
                    break
                case storyType.jsEmbed.rawValue:
                    createCell(cell: storyDetailLayoutType.storyDetailJsEmbbedElementCell,storyElement:storyElement)
                    break
                case storyType.media.rawValue:
                    //                    createCell(cell: storyDetailLayoutType.media)
                    break
                case storyType.pollType.rawValue:
                    //                    createCell(cell: storyDetailLayoutType.poll)
                    break
                case storyType.text.rawValue:
                    createCell(cell: storyDetailLayoutType.storyDetailTextElementCell,storyElement:storyElement)
                    break
                case storyType.video.rawValue:
                    //                    createCell(cell: storyDetailLayoutType.video)
                    break
                case storyType.youtubePlayer.rawValue:
                    createCell(cell: storyDetailLayoutType.storyDetailYoutubeElementCell,storyElement:storyElement)
                    
                    break
                    
                case storyType.title.rawValue:
                    createCell(cell: storyDetailLayoutType.storyDetailTitleElementCell,storyElement:storyElement)
                    
                default:
                    //print("break; unknow item")
                    break
                }
                break
                
        
            default:
                //print("break; unknow item")
                break
            }
        }
    }
    
    func createCell(cell:storyDetailLayoutType,storyElement:CardStoryElement){
        var layoutArray:StoryDetailLayout!
        layoutArray = StoryDetailLayout(layoutType: cell, storyElement: storyElement)
        layoutEngineArray.append(layoutArray)
    }
    
    
    
}
