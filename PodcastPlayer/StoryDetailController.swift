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

    let screenBounds  = UIScreen.main.bounds
    var object : LayoutEngine!
    var source = [LayoutEngine]()
    
    var collectionView : IGListCollectionView = {
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
//        view.backgroundColor = UIColor.red
        return view
    }()
    
    lazy var adaptor:IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let manager = ApiManager(delegate: self)
        manager.getStoryForId(id: self.object.story.id!)
        
        self.adaptor.collectionView = self.collectionView
        self.adaptor.dataSource = self
    }
    
    override func loadView() {
        self.view = UIView.init(frame: screenBounds)
        self.view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    
    func getCardElements(){
        let cards = self.object.story.cards
        source.append(LayoutEngine(story: self.object.story, type: Type.First))
        for card in cards{
            
            let textElements = card.story_elements.filter({$0.type == "text"})
            let layout = LayoutEngine(story: self.object.story, type: Type.TextElement)
            layout.storyElements = textElements
            source.append(layout)
            
            
//            source.append(contentsOf: textElements)
        }
        
    }
}
extension StoryDetailController:ApiManagerDelegate{
    func didloadStory(story: Story?) {
        self.object.story = story!
        getCardElements()
        adaptor.performUpdates(animated: true, completion: nil)
        
    }
}

extension StoryDetailController : IGListAdapterDataSource{
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return DetailSectionController()
        
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
    
}
