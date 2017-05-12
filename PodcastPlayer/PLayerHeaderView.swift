//
//  PLayerHeaderCell.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 5/11/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class PLayerHeaderView: UIView {
    
    
    let trackNameLabel :UILabel = {
        let label = UILabel()
        label.text = "pavan"
        label.numberOfLines = 1
        return label
    }()
    let artistLabel : UILabel = {
        let label = UILabel()
        label.text = "pavan"
        label.numberOfLines = 1
        return label
    }()
    
    let slider: UISlider = {
        let seeker = UISlider()
        seeker.minimumValue = 0
        seeker.maximumValue = 1
        seeker.value = 0
        return seeker
    }()
    
    let startLabel : UILabel = {
        let label = UILabel()
        label.text = "pavan"
        label.numberOfLines = 1
        return label
    }()
    
    let endLabel : UILabel = {
        let label = UILabel()
        label.text = "pavan"
        label.numberOfLines = 1
        return label
    }()
    
    let buttonsContainerView:UIView = {
        let view = UIView()
        return view
    }()
    
    let playButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play_icon"), for: .normal)
        return button
    }()
    
    let nextButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play_icon"), for: .normal)
        return button
    }()
    
    let skipReverseButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "play_icon"), for: .normal)
        return button
    }()
    
    
    var qtObject : QTGlobalProtocol!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame:CGRect,qtObject : QTGlobalProtocol){
        self.init(frame:frame)        
        self.qtObject  = qtObject
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        let view = self
        
        view.addSubview(trackNameLabel)
        view.addSubview(artistLabel)
        view.addSubview(slider)
        view.addSubview(startLabel)
        view.addSubview(endLabel)
        view.addSubview(buttonsContainerView)
        
        buttonsContainerView.addSubview(skipReverseButton)
        buttonsContainerView.addSubview(playButton)
        buttonsContainerView.addSubview(nextButton)
        
        trackNameLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        artistLabel.anchor(trackNameLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 25, bottomConstant: 0, rightConstant: 25, widthConstant: 0, heightConstant: 0)
        
        slider.anchor(artistLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 20, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        startLabel.anchor(slider.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 0)
        
        endLabel.anchor(slider.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 40, heightConstant: 0)
        
        
        buttonsContainerView.anchor(slider.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 60, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 100)
        
        skipReverseButton.anchor(buttonsContainerView.topAnchor, left: buttonsContainerView.leftAnchor, bottom: buttonsContainerView.bottomAnchor, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        playButton.anchor(buttonsContainerView.topAnchor, left: nil, bottom: buttonsContainerView.bottomAnchor, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        nextButton.anchor(buttonsContainerView.topAnchor, left: nil, bottom: buttonsContainerView.bottomAnchor, right: buttonsContainerView.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 10, rightConstant: 10, widthConstant: 30, heightConstant: 30)
        
        
        self.qtObject.playerManager.multicastDelegate.addDelegate(delegate: self)
        
        slider.addTarget(self, action: #selector(self.beginScrubbing(slider:)), for: .touchDown)
        slider.addTarget(self, action: #selector(self.scrub(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(self.scrub(slider:)), for: .touchDragInside)
        slider.addTarget(self, action: #selector(self.endScrubbing(slider:)), for: .touchCancel)
        slider.addTarget(self, action: #selector(self.endScrubbing(slider:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(self.endScrubbing(slider:)), for: .touchUpOutside)
        playButton.addTarget(self, action: #selector(self.didClickOnPlay(button:)), for: .touchUpInside)
        
        nextButton.addTarget(self, action: #selector(self.didClickOnNext(sender:)),for:.touchUpInside)
        
    }
    
    func configure(){
        
    }
    
    func caculateSize(targetSize : CGSize) -> CGSize{
        let contentView = self
        
        var newSize = targetSize
        newSize.width = targetSize.width
        
        let widthConstraint = NSLayoutConstraint(item: self,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant:newSize.width)
        
        contentView.addConstraint(widthConstraint)
        
        var size = UILayoutFittingCompressedSize
        size.width = newSize.width
        
        let cellSize = self.systemLayoutSizeFitting(size, withHorizontalFittingPriority: 1000, verticalFittingPriority:1)
        contentView.removeConstraint(widthConstraint)
        
        return cellSize
        
    }
    
    deinit {
        self.qtObject.playerManager.multicastDelegate.removeDelegate(delegate: self)
    }
}


extension PLayerHeaderView:PlayerManagerDelegate{
    
    func playerManager(manager:PlayerManager,periodicTimeObserverEventDidOccur time:CMTimeWrapper) {
        let displayTime = formatTimeFromSeconds(seconds: time.seconds)
        
    }
    
    func resetDisplayIfNecessary(manager:PlayerManager) {
        
    }
    
    func durationDidBecomeInvalidWhileSyncingScrubber(manager:PlayerManager){
        
    }
    
    func playerManager(manager: PlayerManager, syncScrubberWithCurrent time: Double, duration:Double) {
        
    }
    
    func setPlayButton(state:PlayerState){
        switch state {
        case .Playing:
            UIView.transition(with: self.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.playButton.setImage(UIImage(named: "pause_icon")!, for: .normal)
            }, completion: nil)
        case .Paused:
            UIView.transition(with: self.playButton, duration: 0.5, options: UIViewAnimationOptions .curveLinear, animations: {
                self.playButton.setImage(UIImage(named: "play_icon")!, for: .normal)
            }, completion: nil)
        default:
            break
        }
    }
    
    func setPlayeritemDuration(duration: Double) {
        let displayTime = formatTimeFromSeconds(seconds: duration)
        
    }
    
    
    func didsetArtWorkWithUrl(url:URL?){
        
    }
    
    func didsetName(title: String?, AutorName: String?) {
        
    }
    
    func shouldShowMusicPlayer(shouldShow:Bool){
        
    }
}

extension PLayerHeaderView{
    
    func beginScrubbing(slider:UISlider){
        self.qtObject.playerManager.beginScrubbing()
    }
    
    
    func scrub(slider:UISlider){
        self.qtObject.playerManager.scrub(value: self.slider.value, minValue: self.slider.minimumValue, maxValue: self.slider.maximumValue) { (seeking) in
            print(seeking)
        }
    }
    
    
    func endScrubbing(slider:UISlider){
        self.qtObject.playerManager.endScrubbing()
    }
    
    func didClickOnPlay(button:UIButton){
        self.qtObject.playerManager.didClickOnPlay()
    }
    
    func didClickOnNext(sender:UIButton){
        self.qtObject.playerManager.didClickOnNext()
    }
    
    func forwardButtonHeld(sender: UILongPressGestureRecognizer){
        
        if sender.state == .ended{
            print("ended")
            self.qtObject.playerManager.didFastForward(withRate:1)
        }else if sender.state == .began{
            print("began")
            self.qtObject.playerManager.didFastForward(withRate:2)
        }
        
        print(#function)
    }
}
