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

class StoryDetailController: BaseViewController {
    
    var storyDetaillayout2DArray : [StoryDetailLayout] = []
    
    
    let screenBounds  = UIScreen.main.bounds
    var object : LayoutEngine!
    var source = [LayoutEngine]()
    var story: Story!
    var dataSource : [String] = []
    
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
        
        let manager = ApiManager(delegate: self)
        manager.getStoryForId(id: self.object.story.id!)
        
        self.adaptor.collectionView = self.collectionView
        self.adaptor.dataSource = self
    }
    
    override func loadView() {
        self.view = UIView.init(frame: screenBounds)
        
    }
    
    func getCardElements(){
        let cards = self.object.story.cards
        source.append(LayoutEngine(story: self.object.story, type: Type.First))
        for card in cards{
            
            let textElements = card.story_elements.filter({$0.type == "text"})
            let layout = LayoutEngine(story: self.object.story, type: Type.TextElement)
            layout.storyElements = textElements
            source.append(layout)
            
        }
    }
    
}

extension StoryDetailController:ApiManagerDelegate{
    func didloadStory(story: Story?) {
        self.object.story = story!
        self.story = story!
        let layoutEngine = StoryDetailLayoutEngine(story: story!)
        layoutEngine.makeLayouts { (storyDetailLayout2DArray) in
            self.storyDetaillayout2DArray = storyDetailLayout2DArray
            print(self.storyDetaillayout2DArray)
            self.dataSource.append("pavan")
            self.adaptor.performUpdates(animated: true, completion: nil)
        }
       
    }
}

extension StoryDetailController : IGListAdapterDataSource{
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        print(self.storyDetaillayout2DArray)
        
        //        return self.storyDetaillayout2DArray
        return dataSource as [IGListDiffable]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        //        return DetailSectionController(story: self.story)
        return DetailSectionController.init(layout: self.storyDetaillayout2DArray,story: self.story)
        
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
}
