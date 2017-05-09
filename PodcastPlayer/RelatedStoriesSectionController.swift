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
    
    var stories:[Story] = []
    
    var storiesLoaded = false
    
    init(storyID:String){
        super.init()
        let manager = ApiManager.init(delegate: self)
        manager.getRelatedStory(storyId: storyID)
        supplementaryViewSource = self
    }
}

extension RelatedStoriesSectionController:ApiManagerDelegate{
    func didloadRelatedStories(stories: [Story]?) {
        
        DispatchQueue.main.async {
            self.stories = stories!
            self.collectionContext?.performBatch(animated: false, updates: {
                self.storiesLoaded = true
                self.collectionContext?.reload(self)
            }, completion: nil)
            
        }
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
        print("RelatedStoriesSectionController called")
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
        return [UICollectionElementKindSectionHeader,UICollectionElementKindSectionFooter]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
        case UICollectionElementKindSectionHeader:
            let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, for: self, class: RelatedStoriesTitleCell.self, at: index) as? RelatedStoriesTitleCell
            view?.setText(text: "RELATED ARTICLES")
            return view!
        default:
            let view  = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, for: self, class: SpinnerCell.self, at: index) as!  SpinnerCell
            view.showActivity()
            
            return view
        }
        
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        switch elementKind {
        case UICollectionElementKindSectionHeader:
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
            
        default:
            
           return (storiesLoaded ? CGSize(width: collectionContext!.containerSize.width, height: 0) : CGSize(width: collectionContext!.containerSize.width, height: 30))
            
        }
        
    }
}
