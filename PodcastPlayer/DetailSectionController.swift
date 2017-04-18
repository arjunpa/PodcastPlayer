//
//  DetailSectionController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/11/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import IGListKit
import Quintype



class DetailBaseIGListSectionController:IGListSectionController{
    
    var baseController:BaseViewController?{
        get{
            return self.viewController as? BaseViewController
        }
    }
}

class DetailSectionController:DetailBaseIGListSectionController{
    
    var data: LayoutEngine!
    
    var sizingCells:[String:BaseCollectionCell] = [:]
    override init(){
        super.init()
        self.prepareSizingCells()
    }
    
    func prepareSizingCells(){
        let cells:[BaseCollectionCell.Type] = [HeaderImageElementCell.self, TextElementCell.self]
        
        for cell in cells{
            
            let object = cell.init(frame:CGRect.zero)
            object.setNeedsUpdateConstraints()
            object.updateConstraintsIfNeeded()
            sizingCells[NSStringFromClass(cell)] = object
        }
    }
    
}

extension DetailSectionController: IGListSectionType{
    
    func numberOfItems() -> Int {
        if data.type == Type.First{
        return 1
        }else{
            return data.storyElements.count
        }
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        if data.type == Type.First{
        let cell = collectionContext?.dequeueReusableCell(of: HeaderImageElementCell.self, for: self, at: index) as!HeaderImageElementCell
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
        cell.configure(data: data.story)
        return cell
        }else{
            let cell = collectionContext?.dequeueReusableCell(of: TextElementCell.self, for: self, at: index) as!  TextElementCell
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            cell.configure(data: data.storyElements[index])
            return cell
        }
        
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard  collectionContext != nil else {
            return CGSize.zero
        }
        if data.type == Type.First{
        let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
       // let sizingCell = HeaderImageElementCell.init(frame:CGRect.zero)
        let sizingCell = sizingCells["PodcastPlayer.HeaderImageElementCell"]!
        sizingCell.configure(data: data.story)
        let size =  sizingCell.caculateSize(targetSize: targetSize)
        return size
//              return CGSize.init(width: UIScreen.main.bounds.width, height: 200)
        }else{
            let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
           // let sizingCell = TextElementCell.init(frame:CGRect.zero)
//             let sizingCell = sizingCells["PodcastPlayer.TextElementCell"]!
//            sizingCell.configure(data: data.storyElements[index])
//            let size =  sizingCell.caculateSize(targetSize: targetSize)
//            return CGSize.init(width: UIScreen.main.bounds.width, height: 200)
            let size = TextElementCell.calcHeight(data:  data.storyElements[index], targetSize: targetSize)
            return size
        }
        
    }
    
    func didUpdate(to object: Any) {
        self.data = object as? LayoutEngine
    }
    
    
    func didSelectItem(at index: Int) {
        print(index)
    }
    
    
    
    
}
