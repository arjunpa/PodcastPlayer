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


enum HomeSection:String{
    case Dedication
}

class DedicationViewController: BaseViewController {
    
    var isLoading = false
    var manager :  ApiManager!
    var offset = 0
    var limit = 10
    var loadMore = true
    
    var storyArray = [Story]()
    var homeEngine = HomeLayoutEngine()
    
    var headerSectionController : HeaderSectionController!
    
    
    var collectionView : IGListCollectionView = {
        let layout = UICollectionViewFlowLayout()

        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return view
    }()
    
    lazy var adaptor:IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerSectionController = HeaderSectionController()
        self.view.addSubview(collectionView)
        adaptor.collectionView = self.collectionView
        adaptor.dataSource = self
        
        adaptor.scrollViewDelegate = headerSectionController
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension DedicationViewController :IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return [HomeSection.Dedication,self.homeEngine].map({$0 as! IGListDiffable})
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController{
        if let unwrappedSectionType = object as? HomeSection{
            //static sections
            switch unwrappedSectionType {
            case .Dedication:
                return dedicationRequestSectionController()
            }
            
        }else{
            
            return headerSectionController
        }
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}


extension DedicationViewController:Themeable{
    func applyTheme(theme: Theme) {
        
    }
}

