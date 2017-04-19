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
    
    var source = [LayoutEngine(type: Type.RequestDedication)]
    var isLoading = false
    var manager :  ApiManager!
    var offset = 0
    var limit = 10
    var loadMore = true

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
        collectionView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 100, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        adaptor.collectionView = self.collectionView
        adaptor.dataSource = self
        adaptor.scrollViewDelegate = self
        manager = ApiManager.init(delegate: self)
        manager.getStories(offset: offset, limit: limit)
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
}

extension DedicationViewController : UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !isLoading && distance < 200{
            isLoading = true
            adaptor.performUpdates(animated: true, completion: nil)
            manager.getStories(offset: offset, limit: limit)
            
        }
    }
}

extension DedicationViewController :IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var object = source
        if source.count > 1 {
            source[1].type = Type.First
        }
        
        if loadMore{
            object.append(LayoutEngine(type: Type.Loader))
        }
        return object
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if let obj = object as? LayoutEngine{
            if obj.type == Type.Loader{
                return spinnerSectionController()
            }else{
                return HeaderSectionController()
            }
        }
        return HeaderSectionController()
       
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}

extension DedicationViewController: ApiManagerDelegate{
    func didloadStories(stories:[Story]?){
        isLoading = false
        self.stories = stories!
        offset += self.stories.count
        
        if (stories?.count)! < limit{
            loadMore = false
        }
        preparelayout()
        
        adaptor.performUpdates(animated: true, completion: nil)
        
        print(stories!)
    }
    
    func preparelayout(){
        let engineObjects = (stories.map { (story) -> LayoutEngine in
            return LayoutEngine(story: story)
        })
//        engineObjects.first?.type = Type.First
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

