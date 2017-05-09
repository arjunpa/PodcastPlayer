//
//  StoryDetailLayout.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/30/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation
import Quintype


public enum storyDetailLayoutType : String{
    
    case storyDetailHeaderImageElementCell = "storyDetailHeaderImageElementCell"
    case storyDetailHeaderTextElementCell = "storyDetailHeaderTextElementCell"
    case storyDetailSocialShareElementCell = "storyDetailSocialShareElementCell"
    case storyDetailTextElementCell = "storyDetailTextElementCell"
    case storyDetailBlockkQuoteElementCell = "storyDetailBlockkQuoteElementCell"
    case storyDetailQuoteElementCell = "storyDetailQuoteElementCell"
    case storyDetailBlurbElementCell = "storyDetailBlurbElementCell"
    case storyDetailBigFactElementCell = "storyDetailBigFactElementCell"
    case storyDetailAuthorElemenCell = "storyDetailAuthorElemenCell"
    case storyDetailsTagElementCell = "storyDetailsTagElementCell"
    case galleryElementCell = "galleryElementCell"
    case storyDetailImageElementCell = "storyDetailImageElementCell"
    case storyDetailSummeryElementCell = "storyDetailSummeryElementCell"
    case storyDetailQuestionElementCell = "storyDetailQuestionElementCell"
    case storyDetailAnswerElementCell = "storyDetailAnswerElementCell"
    case storyDetailJsEmbbedElementCell = "storyDetailJsEmbbedElementCell"
    case storyDetailTwitterElementCell = "storyDetailTwitterElementCell"
    case storyDetailYoutubeElementCell =  "storyDetailYoutubeElementCell"
    case storyDetailJWPlayerElementCell =  "storyDetailJWPlayerElementCell"
    case storyDetailCommentElementCell = "storyDetailCommentElementCell"
    
    case storyDetailTitleElementCell = "storyDetailTitleElementCell"
    case storyDetailQandACell  = "storyDetailQandACell"
    
    //    case relatedStoryElementCell = "relatedStoryElementCell"
    
}


class StoryDetailLayout : NSObject{
    
    
    var layoutType:storyDetailLayoutType
    var storyElement:CardStoryElement?
    
    public init(layoutType:storyDetailLayoutType){
        
        self.layoutType = layoutType
        
    }
    
    public init(layoutType:storyDetailLayoutType,storyElement:CardStoryElement){
        self.layoutType = layoutType
        self.storyElement = storyElement
        
    }
    
}
