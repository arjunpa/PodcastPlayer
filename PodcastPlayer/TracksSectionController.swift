//
//  TracksSectionController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 05/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import IGListKit

class TracksSectionController: IGListSectionController {
    var track:TrackWrapper!
    var sizingCell:TrackCell!
    fileprivate var qtObject:QTGlobalProtocol
    init(qtObjectParam:QTGlobalProtocol? = nil){
        if let para = qtObjectParam{
            qtObject = para
        }
        else{
            qtObject = (UIApplication.shared.delegate as! AppDelegate).qtInstance
        }
        super.init()
        inset = UIEdgeInsetsMake(0, 10, 10, 10)
        loadSizingCell()
    }
    func loadSizingCell(){
        let nib = UINib.init(nibName: "TrackCell", bundle: nil)
        sizingCell = nib.instantiate(withOwner: self, options: nil)[0] as! TrackCell
    }
}
extension TracksSectionController:IGListSectionType{
    public func numberOfItems() -> Int{
        return 1
    }
    
    func didUpdate(to object: Any) {
        track = object as! TrackWrapper
    }
    
    public func didSelectItem(at index: Int){
        self.qtObject.playerManager.playWithURL(url: self.track.track.streamURL!)
    }
    
    public func sizeForItem(at index: Int) -> CGSize{
        guard collectionContext != nil else {return CGSize.zero}
        sizingCell.configure(trackWrapper: self.track)
        let width = UIScreen.main.bounds.size.width
        return sizingCell.cellSize(targetSize: CGSize.init(width: width, height: 0.5 * width), inset: inset)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
         guard let context = collectionContext  else {return UICollectionViewCell()}
//        let cellClass:TrackCell.Type = TrackCell.self
//        
//        let cell = context.dequeueReusableCell(of: cellClass, for: self, at: index) as! TrackCell
        let cell = context.dequeueReusableCell(withNibName: "TrackCell", bundle: nil, for: self, at: index) as! TrackCell
        cell.configure(trackWrapper: track)
        return cell
    }
}
