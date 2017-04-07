//
//  MusicLayerController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 07/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class MusicLayerController: BaseViewController {

    var toolbar:PlayerControlsView = {
        let controlView = PlayerControlsView.loadFromNib()
        controlView.seeker.addTarget(self, action: #selector(MusicLayerController.scrub(slider:)), for: .valueChanged)
        controlView.seeker.addTarget(self, action: #selector(MusicLayerController.beginScrubbing(slider:)), for: .touchDown)
        controlView.seeker.addTarget(self, action: #selector(MusicLayerController.endScrubbing(slider:)), for: .touchCancel)
        controlView.seeker.addTarget(self, action: #selector(MusicLayerController.scrub(slider:)), for: .touchDragInside)
        controlView.seeker.addTarget(self, action: #selector(MusicLayerController.endScrubbing(slider:)), for: .touchUpInside)
              controlView.seeker.addTarget(self, action: #selector(MusicLayerController.endScrubbing(slider:)), for: .touchUpOutside)
        
        controlView.playButton.addTarget(self, action: #selector(MusicLayerController.didClickOnPlay(button:)), for: .touchUpInside)
        return controlView
    }()
    var isSeeking:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.qtObject.playerManager.multicastDelegate.addDelegate(delegate: self)
        self.loadPlayerView(toolbar: toolbar)

        // Do any additional setup after loading the view.
    }
    
    func loadPlayerView(toolbar:UIView){
        
        self.view.addSubview(toolbar)
        toolbar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        toolbar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        toolbar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        toolbar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    required init(_ qtObject: QTGlobalProtocol = QTGlobalInstance.init(tdAttributes: nil), nibName: String?, bundle: Bundle?)
        
    {
        super.init(qtObject, nibName: nibName, bundle: bundle)
        self.qtObject = qtObject
        //        self.playerControls = PlayerControlsView.loadFromNib()
        self.playerControls = qtObject.playerManager.playerControls!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        self.qtObject.playerManager.multicastDelegate.removeDelegate(delegate: self)
    }
    
    
    func resetDisplay(){
        self.toolbar.displayTime.text = "00:00:00"
        self.toolbar.seeker.value = 0.0
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

extension MusicLayerController:PlayerManagerDelegate{
      func playerManager(manager:PlayerManager,periodicTimeObserverEventDidOccur time:CMTimeWrapper) {
        let displayTime = formatTimeFromSeconds(seconds: time.seconds)
        self.toolbar.displayTime.text = displayTime
    }
    
    func resetDisplayIfNecessary(manager:PlayerManager) {
        self.toolbar.displayTime.text = "00:00:00"
        self.toolbar.seeker.value = 0.0
    }
    func durationDidBecomeInvalidWhileSyncingScrubber(manager:PlayerManager){
        self.resetDisplay()
        self.toolbar.seeker.minimumValue = 0.0
    }
    
    func playerManager(manager: PlayerManager, syncScrubberWithCurrent time: Double, duration:Double) {
        let minimumValue = Float64(self.toolbar.minimumScaleValue)
        let maximumValue = Float64(self.toolbar.maximumScaleValue)
        let currentTime = Float64(time)
        toolbar.setScaleValue = Float((maximumValue - minimumValue) * currentTime/(duration + minimumValue))
    }
}

extension MusicLayerController{
    func scrub(slider:UISlider){
        self.qtObject.playerManager.scrub(value: self.toolbar.seeker.value, minValue: self.toolbar.seeker.minimumValue, maxValue: self.toolbar.seeker.maximumValue) { (seeking) in
            self.isSeeking = seeking
        }
    }
    
    func beginScrubbing(slider:UISlider){
        self.qtObject.playerManager.beginScrubbing()
    }
    
    func endScrubbing(slider:UISlider){
        self.qtObject.playerManager.endScrubbing()
    }
    
    func didClickOnPlay(button:UIButton){
        self.qtObject.playerManager.didClickOnPlay()
    }
}
