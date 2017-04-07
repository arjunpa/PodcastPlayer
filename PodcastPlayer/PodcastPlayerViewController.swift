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
    @IBOutlet weak var collection_view:IGListCollectionView!
    lazy var igAdaptor:IGListAdapter = {
        return IGListAdapter.init(updater: IGListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
    }()
    required init(_ qtObject:QTGlobalProtocol = QTGlobalInstance.init(tdAttributes: nil), nibName:String?, bundle:Bundle?){
        super.init(qtObject, nibName: nibName, bundle: bundle)
        self.configureSCClient()
    }
    
    
    func configurCollectionView(){
        self.collection_view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        self.collection_view.collectionViewLayout = UICollectionViewFlowLayout()
        igAdaptor.collectionView = self.collection_view
        igAdaptor.dataSource = self
    }
    
    func configureSCClient(){
        SoundcloudClient.clientSecret = "esv5NccmUd0wRgyFgUojqMiNBwM9nZhl"
        SoundcloudClient.clientIdentifier = "fs2FkPBdYj7aNns0zJqgi8ZmR7CAXaBw"
        SoundcloudClient.redirectURI = ""
        
        let queries: [SearchQueryOptions] = [
            .queryString("ed sheeran"),
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
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurCollectionView()
        self.qtObject.playerManager.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        return tracks[_index + 1].track.streamURL
    }
    func playerManagerDidAskForPreviousItem(manager:PlayerManager) -> URL?{
         return tracks[_index - 1].track.streamURL
    }
}
