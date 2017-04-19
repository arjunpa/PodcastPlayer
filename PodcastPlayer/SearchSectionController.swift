//
//  SearchSectionController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/18/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit

protocol SearchSectionControllerDelegate {
    func searchButtonPressed(text:String)
}

class SearchSectionController: IGListSectionController ,IGListAdapterDataSource{

    var number:Int!
    var delegate : SearchSectionControllerDelegate?
    
    override init(){
        super.init()
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
        self.inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        supplementaryViewSource = self
        
    }
    
    lazy var adapter: IGListAdapter = {
        let adapter = IGListAdapter(updater: IGListAdapterUpdater(),
                                    viewController: self.viewController,
                                    workingRangeSize: 0)
        adapter.dataSource = self
        
        return adapter
    }()
    
   
    //MARK: IGListAdapterDataSource
    
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        
        return [1 as IGListDiffable]
    }
    
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return EmbededSectionController()
    }
    
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }

}

extension SearchSectionController :IGListSectionType{
    
    func numberOfItems() -> Int {
    
        if number == 3{
            return 10
        }
        return 1
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        
        if number == 3{
         return  CGSize(width: collectionContext!.containerSize.width, height: 50)
        }else if number == 0{
         return  CGSize(width: collectionContext!.containerSize.width, height: 50)
        }else{
        return CGSize(width: collectionContext!.containerSize.width, height: 150)
        }
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
       if number == 3{
            let cell = collectionContext?.dequeueReusableCell(of: SearchDefaultCell.self, for: self, at: index) as! SearchDefaultCell
            return cell
        }else{
            let cell = collectionContext!.dequeueReusableCell(of: EmbeddedCollectionViewCell.self, for: self, at: index) as! EmbeddedCollectionViewCell
            adapter.collectionView = cell.collectionView
            return cell
        }
    }
    
    func didUpdate(to object: Any) {
        number = object as? Int
    }
    
    func didSelectItem(at index: Int) {}
    
}


extension SearchSectionController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            delegate?.searchButtonPressed(text: text)
        }
    }
}


extension SearchSectionController:IGListSupplementaryViewSource{
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        
        let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, for: self, class: SearchSectionHeaderCell.self, at: index) as! SearchSectionHeaderCell
        view.configure(data: "Tadasdsa")
        return view
         
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        
        return CGSize(width: (self.collectionContext?.containerSize.width)!, height: 50)
        
    }
}
