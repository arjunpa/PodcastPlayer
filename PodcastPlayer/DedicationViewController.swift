//
//  DedicationViewController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit
import Quintype

class DedicationViewController: BaseViewController {

    var stories = [Story]()
    
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
        self.view.addSubview(collectionView)
        adaptor.collectionView = self.collectionView
        adaptor.dataSource = self
        let manager =  ApiManager.init(delegate: self)
        manager.getStories()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    class func newInstance() -> DedicationViewController{
        let dedicationVc = DedicationViewController(nibName: "DedicationViewController", bundle: nil)
        
        return dedicationVc
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }

}

extension DedicationViewController :IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return source
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
       
        return HeaderSectionController()
       
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}

extension DedicationViewController: ApiManagerDelegate{
    func didloadStories(stories:[Story]?){
        self.stories = stories!
        
        preparelayout()
        
        adaptor.performUpdates(animated: true, completion: nil)
        
        print(stories!)
    }
    
    func preparelayout(){
        let engineObjects = (stories.map { (story) -> LayoutEngine in
            
            return LayoutEngine(story: story)
        })
        engineObjects.first?.type = Type.First
       source.append(contentsOf: engineObjects)
    }
    
    
    func handleError(message:String?){
     print(message!)
    }
}

enum Type {
    case First
    case Rest
    case TextElement
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
}

