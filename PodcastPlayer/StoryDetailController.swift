//
//  StoryDetailController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/11/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype
import IGListKit

enum detailLayout:String{
    case storyDetail
    case relatedStory
}

class StoryDetailController: BaseViewController {
    
    var storyDetaillayout2DArray : [StoryDetailLayout] = []
    
    
    let screenBounds  = UIScreen.main.bounds
    
    var object : Story!
    
    var source = [LayoutEngine]()
    var story: Story!
    var dataSource : [String] = []
    var relatedStories : [Story]!
    var manager: ApiManager!
    
    var collectionView : IGListCollectionView = {
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    lazy var adaptor:IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(collectionView)
        self.view.backgroundColor = UIColor.white
        collectionView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        manager = ApiManager(delegate: self)
        manager.getStoryForId(id: self.object.id!)
        
        
        self.adaptor.collectionView = self.collectionView
        self.adaptor.dataSource = self
    }
    
    override func loadView() {
        self.view = UIView.init(frame: screenBounds)
        
    }
    
    func getCardElements(){
        let cards = self.object.cards
        source.append(LayoutEngine(story: self.object, type: Type.Header))
        for card in cards{
            
            let textElements = card.story_elements.filter({$0.type == "text"})
            let layout = LayoutEngine(story: self.object, type: Type.TextElement)
            layout.storyElements = textElements
            source.append(layout)
            
        }
    }
    
}

extension StoryDetailController : IGListAdapterDataSource{
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        
        return dataSource as [IGListDiffable]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController{
        switch object as! String{
        case detailLayout.relatedStory.rawValue:
            return RelatedStoriesSectionController(stories: self.relatedStories)
            
        default:
            return DetailSectionController.init(layout: self.storyDetaillayout2DArray,story: self.story)
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
}

extension StoryDetailController:ApiManagerDelegate{
    func didloadStory(story: Story?) {
        self.object = story!
        self.story = story!
        let layoutEngine = StoryDetailLayoutEngine(story: story!)
        
        layoutEngine.makeLayouts { (storyDetailLayout2DArray) in
            self.manager.getRelatedStory(storyId: self.object.id!)
            
            self.storyDetaillayout2DArray = storyDetailLayout2DArray
            self.dataSource.append(detailLayout.storyDetail.rawValue)
            self.adaptor.performUpdates(animated: true, completion: nil)
        }
    }
    
    func didloadRelatedStories(stories: [Story]?) {
        print("relatedStories loaded")
        if let unwrappedStories = stories{
            self.relatedStories = unwrappedStories
            self.dataSource.append(detailLayout.relatedStory.rawValue)
            self.adaptor.performUpdates(animated: true, completion: nil)
        }else{
            print("No related Stories")
        }
        
    }
}

extension StoryDetailController:Themeable{
    func applyTheme(theme: Theme) {
        print("pavan gopal ")
        self.collectionView.backgroundColor = theme.backgroundColor
    }
}
