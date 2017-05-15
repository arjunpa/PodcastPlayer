//
//  NextControllerViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 11/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import IGListKit

class NextControllerViewController: BaseViewController,UIGestureRecognizerDelegate {
    @IBOutlet weak var rewindButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var displaylabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var rootViewController: ViewController?
    var isSeeking:Bool = false
    var tracks:[TrackWrapper] = []
    var _index = 0
    
    let tableView:UITableView = {
        let view = UITableView(frame: CGRect.zero)
        return view
    }()
    
    var panGesture : UIPanGestureRecognizer!
    var headerView : PLayerHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDataSource()
        
        setUpTableView()
        
        self.qtObject.playerManager.dataSource = self
    }
    
    func updateDataSource(){
        
        self.tracks = self.qtObject.playerManager.getQueuedTracks()!
        
        self._index = self.qtObject.playerManager.getCurrentSongIndex()!
        
    }
    
    func setUpTableView(){
        
        self.view.addSubview(tableView)
        tableView.bounces = false
        
        tableView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        headerView = PLayerHeaderView.loadFromNib(qtObject: self.qtObject)
        
        headerView.delegate = self
        
        tableView.tableHeaderView = headerView
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        tableView.register(PlayerDetailListCell.self, forCellReuseIdentifier: "PlayerDetailListCell")
        
    }
    
    override func loadView() {
        self.view = UIView(frame:UIScreen.main.bounds)
        
    }
    
}

extension NextControllerViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerDetailListCell", for: indexPath) as! PlayerDetailListCell
        
        cell.configure(trackWrapper: self.tracks[indexPath.row],isRowPlaying:self._index == indexPath.row,qtObject:self.qtObject)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self._index = indexPath.row
        self.qtObject.playerManager.dataSource = self
        self.qtObject.playerManager.playWithURL(url: self.tracks[self._index].track.streamURL!)
        self.tableView.reloadData()
    }
    
}

extension NextControllerViewController:PlayerManagerDataSource{
    
    
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
    
    func playerManagerDidAskForArtWorksImageUrl(manager:PlayerManager,size:TrackArtworkImageSize) -> URL?{
        switch size {
        case .small:
            return tracks[self._index].track.artworkImageURL.largeURL
        case .medium:
            return tracks[self._index].track.artworkImageURL.cropURL
        case .large:
            return tracks[self._index].track.artworkImageURL.highURL
        }
        
    }
    
    func playerManagerDidAskForTrackTitleAndAuthor(manager:PlayerManager) -> (String,String){
        let trackD = tracks[self._index].track
        
        return (trackD.title,trackD.createdBy.fullname)
    }
    
    func playerMangerDidAskForQueue() -> [TrackWrapper]{
        return self.tracks
    }
    
    func playerManagerDidAskForCurrentSongIndex() -> Int{
        return _index
    }
}

extension NextControllerViewController : PLayerHeaderViewDeleagte{
    internal func tracksDidChange(tracks: [TrackWrapper]?) {
        guard let unwrappedTracks = tracks else{return}
        
        self.tracks = unwrappedTracks
        
        self.tableView.reloadData()
    }
    
    func trackDidChange(){
        print(#function)
        self.tableView.reloadData()
    }
}


