//
//  MusicLayerController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 07/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class MusicLayerController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let playerToolbar = PlayerControlsView.loadFromNib()
        self.loadPlayerView(toolbar: playerToolbar)

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
