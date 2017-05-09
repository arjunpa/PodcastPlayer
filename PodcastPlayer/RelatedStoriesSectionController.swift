//
//  RelatedStoriesSectionController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/9/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit
import Quintype

class RelatedStoriesSectionController: BaseIGListSectionController {
    
    var stories:[Story]!
    
    init(stories:[Story]){
        super.init()
        self.stories = stories
//        supplementaryViewSource = self
    }
}

extension RelatedStoriesSectionController:IGListSectionType{
    func numberOfItems() -> Int {
        return self.stories.count
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(of: DefaultStoryCell.self, for: self, at: index) as! DefaultStoryCell
        
        cell.configure(data: stories[index])
        
        return cell
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 120)
    }
    
    func didUpdate(to object: Any) {
        //        self.stories = object as? [Story]
    }
    
    
    func didSelectItem(at index: Int) {
        print(index)
        let detailVC = StoryDetailController(self.baseController!.qtObject, nibName:nil, bundle:nil)
        detailVC.object = self.stories[index]
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

extension RelatedStoriesSectionController:IGListSupplementaryViewSource{
    
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionHeader]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, for: self, class: RelatedStoriesTitleCell.self, at: index) as? RelatedStoriesTitleCell
        view?.setText(text: "RELATED ARTICLES")
        return view!
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 30)
    }
}
