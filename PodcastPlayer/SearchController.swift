//
//  SearchController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/17/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit
import Quintype

class SearchController: BaseViewController {
    
    let data = [1,2,3]
    var offset = 0
    let limit = 10

    let searchBar: UISearchBar = {
       let search = UISearchBar()
        return search
        
    }()
    
    let collectionView: IGListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        
       let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: layout)

        return view
    }()
    
    lazy var adaptor :IGListAdapter = {
        return IGListAdapter(updater:IGListAdapterUpdater(),viewController:self,workingRangeSize:0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
        
        self.automaticallyAdjustsScrollViewInsets = false
        searchBar.anchor(self.topLayoutGuide.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView.anchor(self.searchBar.bottomAnchor, left: self.view.leftAnchor, bottom: self.bottomLayoutGuide.topAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        
        adaptor.collectionView = self.collectionView
        adaptor.dataSource = self
        searchBar.delegate = self
        
    }

    override func loadView() {
        super.loadView()
        self.view = UIView(frame:UIScreen.main.bounds)
    }
}

extension SearchController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let manager = ApiManager(delegate: self)
        if let searchText = searchBar.text{
            manager.getStoriesWithSearchString(text: searchText, offset: 0, limit: 10)
        }
        
    }
    
}

extension SearchController:ApiManagerDelegate{
    func didloadStories(stories: [Story]?) {
        print(stories)
    }
}

extension SearchController:IGListAdapterDataSource{
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return data as [IGListDiffable]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return SearchSectionController()
        
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}

class SearchWrapper:NSObject{
    var tracks:[Story]!
    
}


