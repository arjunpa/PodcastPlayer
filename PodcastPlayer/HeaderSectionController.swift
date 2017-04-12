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

class HeaderSectionController : BaseIGListSectionController{
    
    
    var data: LayoutEngine!
    
    var sizingCells:[String:BaseCollectionCell] = [:]
    override init(){
        super.init()
//        prepareSizingCells()
        
        
    }
    
    func prepareSizingCells(){
        let cells:[BaseCollectionCell.Type] = [HeaderImageElementCell.self, DefaultStoryCell.self]
        
        for cell in cells{
           
            let object = cell.init(frame:CGRect.zero)
            object.setNeedsUpdateConstraints()
            object.updateConstraintsIfNeeded()
            sizingCells[NSStringFromClass(cell)] = object
        }
    }
    
}

extension HeaderSectionController: IGListSectionType{
    
    func numberOfItems() -> Int {
        return 1
        
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        if data.type == Type.First{
            let cell = collectionContext?.dequeueReusableCell(of: HeaderImageElementCell.self, for: self, at: index) as!HeaderImageElementCell
//            cell.setNeedsUpdateConstraints()
//            cell.updateConstraintsIfNeeded()
            cell.configure(data: data.story)
            return cell
        }else{
            let cell = collectionContext?.dequeueReusableCell(of: DefaultStoryCell.self, for: self, at: index) as!DefaultStoryCell
//            cell.setNeedsUpdateConstraints()
//            cell.updateConstraintsIfNeeded()
            cell.configure(data: data.story)
            return cell
        }
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard  collectionContext != nil else {
            return CGSize.zero
        }
        if  data.type == Type.First{
            let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let sizingCell = HeaderImageElementCell.init(frame:CGRect.zero)
//            let sizingCell = sizingCells["PodcastPlayer.HeaderImageElementCell"]!
            sizingCell.configure(data: data.story)
            let size =  sizingCell.caculateSize(targetSize: targetSize)
            
            return size
        }else{
            let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let sizingCell = DefaultStoryCell.init(frame:CGRect.zero)
//            let sizingCell = sizingCells["PodcastPlayer.DefaultStoryCell"]!
            sizingCell.configure(data: data.story)
            let size =  sizingCell.caculateSize(targetSize: targetSize)
            
            return size
        }
        
    }
    
    func didUpdate(to object: Any) {
        self.data = object as? LayoutEngine
    }
    
    
    func didSelectItem(at index: Int) {
        print(index)
   
        let detailVC = StoryDetailController(self.baseController!.qtObject, nibName:nil, bundle:nil)
        detailVC.object = self.data
//        self.viewController?.present(detailVC, animated: true, completion: nil)
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
}
