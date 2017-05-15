//
//  playerDetailListCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/14/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Kingfisher

class PlayerDetailListCell: UITableViewCell {
    
    let trackImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let songTitleName : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let artistNameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let playButton : CircleProgressView = {
        let button = CircleProgressView()
        button.setImage(#imageLiteral(resourceName: "playlist_play"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegateAdded = false
    var qtObject : QTGlobalProtocol!
    var activityIndicator = UIActivityIndicatorView()
    
    
    func setUpViews(){
        let view = self.contentView
        
        view.addSubview(trackImage)
        view.addSubview(songTitleName)
        view.addSubview(artistNameLabel)
        view.addSubview(playButton)
    
        trackImage.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 15, leftConstant: 15, bottomConstant: 15, rightConstant: 0, widthConstant: 80, heightConstant: 65)
        
        songTitleName.anchor(view.topAnchor, left: trackImage.rightAnchor, bottom: nil, right:nil, topConstant: 15, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        artistNameLabel.anchor(songTitleName.bottomAnchor, left: trackImage.rightAnchor, bottom: nil, right:nil, topConstant: 5, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        playButton.anchor(nil, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 15, widthConstant: 30, heightConstant: 30)
        
        playButton.anchorCenterYToSuperview()
        
        let spacingConstraint1 =  NSLayoutConstraint.init(item: songTitleName, attribute: .right, relatedBy: .lessThanOrEqual, toItem: playButton, attribute: .left, multiplier: 1, constant: -15)
        
        let spacingConstraint2 =  NSLayoutConstraint.init(item: artistNameLabel, attribute: .right, relatedBy: .lessThanOrEqual, toItem: playButton, attribute: .left, multiplier: 1, constant: -15)
        
        view.addConstraint(spacingConstraint1)
        view.addConstraint(spacingConstraint2)
        
        playButton.delegate = self
    }
    
    func configure(trackWrapper:TrackWrapper,isRowPlaying:Bool,qtObject:QTGlobalProtocol){
        if isRowPlaying{
            if !delegateAdded{
                delegateAdded = true
                qtObject.playerManager.multicastDelegate.addDelegate(delegate: self)
                
                let image = #imageLiteral(resourceName: "playlist_pause").withRenderingMode(.alwaysTemplate)
                
                self.playButton.setImage(image, for: .normal)
                self.playButton.imageView?.tintColor = UIColor.lightGray.withAlphaComponent(0.40)
                
            }
        }else{
               self.playButton.setImage(#imageLiteral(resourceName: "playlist_play"), for: .normal)
        }
            self.trackImage.kf.setImage(with: trackWrapper.track.artworkImageURL.largeURL, placeholder: #imageLiteral(resourceName: "music_pholder"), options: nil, progressBlock: nil, completionHandler: nil)
            self.songTitleName.text = trackWrapper.track.title
            self.artistNameLabel.text = trackWrapper.track.createdBy.fullname
        
    }
    
    func showProgress(progress:Float){
        
        self.perform(#selector(self.setProgress), with: NSNumber.init(value: progress), afterDelay: TimeInterval(0.0))
    }
    
    func setProgress(value:NSNumber){
        DispatchQueue.main.async {
            self.playButton.setProgress(value: value.doubleValue)
        }
    }
    
    override func prepareForReuse() {
        
        self.playButton.imageView?.image = nil
    }
    
    deinit {
        delegateAdded = false
        qtObject.playerManager.multicastDelegate.removeDelegate(delegate: self)
    }
    
}


extension PlayerDetailListCell:PlayerManagerDelegate{
    
    internal func shouldupdateTracksList(tracks: [TrackWrapper]?) {}

    
    func playerManager(manager:PlayerManager,periodicTimeObserverEventDidOccur time:CMTimeWrapper) {
        
    }
    
    func resetDisplayIfNecessary(manager:PlayerManager) {
     
    }
    
    func durationDidBecomeInvalidWhileSyncingScrubber(manager:PlayerManager){}
    
    func playerManager(manager: PlayerManager, syncScrubberWithCurrent time: Double, duration:Double) {
        let minimumValue = Float64(0)
        let maximumValue = Float64(1)
        let currentTime = Float64(time)
        let progress = (maximumValue - minimumValue) * currentTime/(duration + minimumValue)
        
        self.showProgress(progress: Float(progress))
    }
    
    func setPlayButton(state:PlayerState){
        switch state {
        case .Playing:
            
            hideActivityIndicator()
            UIView.transition(with: self.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                let image = #imageLiteral(resourceName: "playlist_pause").withRenderingMode(.alwaysTemplate)
                
                self.playButton.setImage(image, for: .normal)
                self.playButton.imageView?.tintColor = UIColor.lightGray.withAlphaComponent(0.40)
            }, completion: nil)
            
        case .Paused:
            
            hideActivityIndicator()
            UIView.transition(with: self.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.playButton.setImage(#imageLiteral(resourceName: "playlist_play"), for: .normal)
            }, completion: nil)
            
        case .Buffering:
            
            self.playButton.setImage(nil, for: .normal)
            showActivityIndicator()
            break
            
        case .ReadyToPlay:
            
            self.playButton.setImage(nil, for: .normal)
            showActivityIndicator()
            break
            
        case .Interrupted:
            
            break
            
        }
    }
    
    func setPlayeritemDuration(duration: Double) {
    //this will called for a new song once; you can reset the progress here
        
        
    }
    
    func didsetArtWorkWithUrl(url:URL?){}
    
    func didsetName(title: String?, AutorName: String?) {}
    
    func shouldShowMusicPlayer(shouldShow:Bool){}
    
    func showActivityIndicator(){
        
        //create only if not created before
        if  let unwrappedActivityIndicator = self.playButton.subviews.filter({$0.isKind(of: UIActivityIndicatorView.self)}).first{
            unwrappedActivityIndicator.removeFromSuperview()
        }else{
            activityIndicator = createActivityIndicator()
        }
        
        self.playButton.addSubview(activityIndicator)
        activityIndicator.anchorCenterSuperview()
        activityIndicator.startAnimating()
        
    }
    
    func hideActivityIndicator(){
        activityIndicator.stopAnimating()
    }
    
    func createActivityIndicator() -> UIActivityIndicatorView{
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        
        activityIndicator.color = UIColor.white
        
        return activityIndicator
    }
}

extension PlayerDetailListCell : CircleProgressViewDelegate{
    func didFinishAnimation(progressView: CircleProgressView) {
        print(#function)
        progressView.removeFromSuperview()
    }
}
