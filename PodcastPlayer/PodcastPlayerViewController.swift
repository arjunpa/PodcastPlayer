//
//  PodcastPlayerViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 03/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Soundcloud
import IGListKit


class PodcastPlayerViewController: BaseViewController {
    
    var tracks:[TrackWrapper] = []
    fileprivate var _index:Int = 0
    let kTabBarHeight:CGFloat = 50
    
    var collection_view:IGListCollectionView = {
       let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    lazy var igAdaptor:IGListAdapter = {
        return IGListAdapter.init(updater: IGListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSCClient()
        self.configurCollectionView()
        self.qtObject.playerManager.dataSource = self
    }

    func configurCollectionView(){
        self.view.addSubview(collection_view)
        
        collection_view.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        collection_view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        collection_view.backgroundColor = UIColor.lightGray
        
        igAdaptor.collectionView = self.collection_view
        igAdaptor.dataSource = self
    }
    
    func configureSCClient(){
        SoundcloudClient.clientSecret = "esv5NccmUd0wRgyFgUojqMiNBwM9nZhl"
        SoundcloudClient.clientIdentifier = "fs2FkPBdYj7aNns0zJqgi8ZmR7CAXaBw"
        SoundcloudClient.redirectURI = ""
        
        let queries: [SearchQueryOptions] = [
            .queryString("malayalam"),
            .types([TrackType.live, TrackType.demo])
        ]
        
        Track.search(queries: queries) {[weak self] (response:PaginatedAPIResponse<Track>) in
            
            guard let weakSelf = self else{return}
            let tracksd = response.response.result ?? []
            weakSelf.tracks = tracksd.map({ (track:Track) -> TrackWrapper in
                return TrackWrapper.init(track: track)
            })
            DispatchQueue.main.async(execute: {
                self?.igAdaptor.reloadData(completion: nil)
            })
        }
    }

}

extension PodcastPlayerViewController:IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return self.tracks
    }
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        
        let controller = TracksSectionController.init()
        controller.delegate = self
        return controller
    }
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}

extension PodcastPlayerViewController:TracksSectionControllerDelegate{
    func sectionIndexSelected(controller: IGListSectionController, index: Int) {
        
        self._index = index
    }
}

extension PodcastPlayerViewController:PlayerManagerDataSource{
    

    func playerManagerDidReachEndOfCurrentItem(manager:PlayerManager){
    
    }
    
    func playerManagerShoulMoveToNextItem(manager:PlayerManager) -> Bool{
        if _index < self.tracks.count - 1{
            return true
        }
        return false
    }
    
     func playerManagerShoulMoveToPreviousItem(manager:PlayerManager) -> Bool{
        
        if _index > 0{
            return true
        }
        return false
    }
    
    func playerManagerDidAskForNextItem(manager:PlayerManager) -> URL?{
        _index += 1
        return tracks[_index].track.streamURL
    }
    
    func playerManagerDidAskForPreviousItem(manager:PlayerManager) -> URL?{
        _index -= 1
         return tracks[_index - 1].track.streamURL
    }
    
    func playerManagerDidAskForArtWorksImageUrl(manager:PlayerManager) -> URL?{
        return tracks[self._index].track.artworkImageURL.largeURL
    }
    
    func playerManagerDidAskForTrackNameDetails(manager:PlayerManager) -> (String,String){
        let trackD = tracks[self._index].track
        
        return (trackD.title,trackD.createdBy.fullname)
    }
}
