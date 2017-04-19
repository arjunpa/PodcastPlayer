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
        
    }
    
}

extension HeaderSectionController: IGListSectionType{
    
    func numberOfItems() -> Int {
        return 1
        
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        switch data.type! {
        case Type.First:
            let cell = collectionContext?.dequeueReusableCell(of: HeaderImageElementCell.self, for: self, at: index) as!HeaderImageElementCell
            cell.configure(data: data.story)
            return cell
        case Type.RequestDedication:
            
            let cell = collectionContext?.dequeueReusableCell(of: DedicationRequestCell.self, for: self, at: index) as! DedicationRequestCell
            return cell
            
        default:
            let cell = collectionContext?.dequeueReusableCell(of: DefaultStoryCell.self, for: self, at: index) as!DefaultStoryCell
            cell.configure(data: data.story)
            return cell
        }
        
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        guard  collectionContext != nil else {
            return CGSize.zero
        }
        switch data.type! {
        case Type.First:
            let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let sizingCell = HeaderImageElementCell.init(frame:CGRect.zero)
            sizingCell.configure(data: data.story)
            let size =  sizingCell.caculateSize(targetSize: targetSize)
            
            return size
            case Type.RequestDedication:
                let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            return CGSize(width: UIScreen.main.bounds.width, height: 65)
        default:
            let targetSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let sizingCell = DefaultStoryCell.init(frame:CGRect.zero)
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
        self.viewController?.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}


