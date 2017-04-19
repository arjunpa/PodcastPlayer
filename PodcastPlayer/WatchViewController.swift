//
//  WatchViewController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/17/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit
import Quintype

class WatchViewController: BaseViewController {
    
    var stories = [Story]()
    
    var source = [LayoutEngine]()
    var isLoading = false
    var manager :  ApiManager!
    var offset = 0
    var limit = 10
    var loadMore = true
    
    let screenBounds  = UIScreen.main.bounds
    
    let collectionView: IGListCollectionView = {
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
       return view
    }()
    
    lazy var adaptor : IGListAdapter = {
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
        manager.getStoriesBySection(sectionName: "videos", offset: offset, limit: limit)
    }
    
    override func loadView() {
        super.loadView()
        self.view = UIView(frame: screenBounds)
    }
}


extension WatchViewController: IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var objects = source
        if source.count > 0 {
            source[0].type = Type.First
        }
        if loadMore{
            objects.append(LayoutEngine(type: .Loader))
        }
        return objects
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



extension WatchViewController : UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !isLoading && distance < 200{
            isLoading = true
            adaptor.performUpdates(animated: true, completion: nil)
            manager.getStories(offset: offset, limit: limit)
            
        }
    }
}

extension WatchViewController: ApiManagerDelegate{
    func didloadStories(stories:[Story]?){
        isLoading = false
        self.stories = stories!
        offset += self.stories.count
        
        preparelayout()
        
        if (stories?.count)! < limit{
            loadMore = false
        }
        adaptor.performUpdates(animated: true, completion: nil)
        
    }
    
    func preparelayout(){
        let engineObjects = (stories.map { (story) -> LayoutEngine in
            return LayoutEngine(story: story)
        })
 
        source.append(contentsOf: engineObjects)
        
        
    }
    
    func handleError(message:String?){
        print(message!)
    }
}
