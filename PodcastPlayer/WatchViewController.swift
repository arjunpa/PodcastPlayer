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
    
    var storyArray = [Story]()
    
    var homeEngine = HomeLayoutEngine()
    
    let screenBounds  = UIScreen.main.bounds
    var headerSectionController : HeaderSectionController!
    
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
        collectionView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
       headerSectionController = HeaderSectionController()
        
        adaptor.scrollViewDelegate = headerSectionController
        adaptor.collectionView = self.collectionView
        adaptor.dataSource = self
        
    }
    
    override func loadView() {
        super.loadView()
        self.view = UIView(frame: screenBounds)
    }
}


extension WatchViewController: IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        
        return [homeEngine as! IGListDiffable]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return headerSectionController
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}

