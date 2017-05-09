//
//  HeaderSectionController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import IGListKit
import Quintype

class BaseIGListSectionController:IGListSectionController{
    
    var baseController:BaseViewController?{
        get{
            return self.viewController as? BaseViewController
        }
    }
}

enum homeCellType:String{
    case headerImageElementCell
    case defaultStoryCell
}

class HeaderSectionController : BaseIGListSectionController{
    
    let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
    
    var sizingCells:[String:BaseCollectionCell] = [:]
    
    var engine  = HomeLayoutEngine()
    var showLoader = true
    var manager :  ApiManager!
    var isLoading = false
    var offset = 0
    var limit = 10
    var loadMore = false
    
    var headerSize : CGSize!
    
    override init(){
        super.init()
        print("INIT")
        prepareSizingCells()
        
        supplementaryViewSource = self
        manager = ApiManager.init(delegate: self)
        manager.getStories(offset: offset, limit: limit)
        
//        manager.getStoriesWithSearchString(text: "q and a", offset: offset, limit: limit)
    }
    
    func prepareSizingCells(){
        let headerImageElementCell = HeaderImageElementCell.init(frame:CGRect.zero)
        sizingCells[homeCellType.headerImageElementCell.rawValue] = headerImageElementCell
        
        let defaultStoryCell = DefaultStoryCell.init(frame:CGRect.zero)
        sizingCells[homeCellType.defaultStoryCell.rawValue] = defaultStoryCell
        
    }
}


extension HeaderSectionController: ApiManagerDelegate{
    func didloadStories(stories:[Story]?){
        isLoading = false
        guard let newElements = stories else{
            return
        }
        offset += newElements.count
        
        if (stories?.count)! < limit{
            loadMore = false
            showLoader = false
        }

        DispatchQueue.main.async {

            self.engine.stories.append(contentsOf: newElements)
            self.collectionContext?.performBatch(animated: false, updates: {
                self.collectionContext?.reload(self)
            }, completion: nil)

        }
        
    }
    
    func handleError(message:String?){
        print(message!)
    }
}


extension HeaderSectionController : UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !isLoading && distance < 200{
            isLoading = true
            
            self.manager.getStories(offset: self.offset, limit: 10)
            
        }
    }
}

extension HeaderSectionController: IGListSectionType{
    
    func numberOfItems() -> Int {
        return engine.stories.count
        
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell?
        
        let data = engine.stories[index]
        
        switch index {
            
        case 0:
             cell = collectionContext?.dequeueReusableCell(of: HeaderImageElementCell.self, for: self, at: index)
            let currentCell = cell as? HeaderImageElementCell
             
            currentCell?.configure(data: data)
            
            
        default:
             cell = collectionContext?.dequeueReusableCell(of: DefaultStoryCell.self, for: self, at: index)
             let currentCell = cell as? DefaultStoryCell
             
            currentCell?.configure(data: data)
            
        }
        return cell!
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        
        let data = engine.stories[index]
        
        guard  collectionContext != nil else {
            return CGSize.zero
        }
        
        switch index {
        case 0:

            let sizingCell = sizingCells[homeCellType.headerImageElementCell.rawValue] as! HeaderImageElementCell
            
            sizingCell.configure(data: data)
            
            let size =  sizingCell.caculateSize(targetSize: targetSize)
            return size
            

        default:
            
            return CGSize(width: collectionContext!.containerSize.width, height: 120)
        }
    }
    
    func didUpdate(to object: Any) {
        if let unwrappedEngine = object as? HomeLayoutEngine{
            self.engine = unwrappedEngine
            if self.engine.stories.count > 0{
                prepareSizingCells()
            }
        }
    }
    
    func didSelectItem(at index: Int) {
        print(index)
        
        let detailVC = StoryDetailController(self.baseController!.qtObject, nibName:nil, bundle:nil)
        detailVC.object = self.engine.stories[index]
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}


extension HeaderSectionController:IGListSupplementaryViewSource{
    // MARK: IGListSupplementaryViewSource
    
    func supportedElementKinds() -> [String] {
        return [UICollectionElementKindSectionFooter]
    }
    
    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        
        let view  = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, for: self, class: SpinnerCell.self, at: index) as!  SpinnerCell
        view.showActivity()
        
        return view
    }
    
    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        if showLoader{
            return CGSize(width: collectionContext!.containerSize.width, height: 40)
        }else{
            return CGSize.zero
        }
    }
}

