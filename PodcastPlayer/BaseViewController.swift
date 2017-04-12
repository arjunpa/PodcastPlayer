//
//  BaseViewController.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 04/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit


protocol BaseControllerProtocol:class{
    var qtObject:QTGlobalProtocol{
        get set
    }
     init(_ qtObject:QTGlobalProtocol, nibName:String?, bundle:Bundle?)
}

class BaseViewController: UIViewController, BaseControllerProtocol {
    internal var qtObject: QTGlobalProtocol
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.beginReceivingRemoteControlEvents()
        // Do any additional setup after loading the view.
    }

    required init(_ qtObject: QTGlobalProtocol = QTGlobalInstance.init(tdAttributes: nil), nibName: String?, bundle: Bundle?)
        
    {
        self.qtObject = qtObject
//        self.playerControls = PlayerControlsView.loadFromNib()
//        self.playerControls = qtObject.playerManager.playerControls!
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
   
}
