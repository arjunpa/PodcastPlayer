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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PodcastPlayerViewController:IGListAdapterDataSource{
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        return self.tracks
    }
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        return TracksSectionController.init()
    }
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}
