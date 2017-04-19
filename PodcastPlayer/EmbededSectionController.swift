//
//  EmbededSectionController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/18/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit
import Quintype

class EmbededSectionController: IGListSectionController {

    var data : Any!
    
    override init(){
        super.init()
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
        
    }
}

extension EmbededSectionController:IGListSectionType{
    func numberOfItems() -> Int {
        return 10
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(of: GridCell.self, for: self, at: index) as! GridCell
        cell.configure(data: data)
        return cell
    }
    
    func sizeForItem(at index: Int) -> CGSize {
        let width = collectionContext?.containerSize.width ?? 0
        let itemSize = floor(width / 4)
        print(itemSize)
        return CGSize(width: 100, height: 150)
    }
    
    func didUpdate(to object: Any) {
        data = object
    }
    
    func didSelectItem(at index: Int) {
        print(index)
    }
    
}
