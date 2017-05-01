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
     init(_ qtObject:QTGlobalProtocol?, nibName:String?, bundle:Bundle?)
}

class BaseViewController: UIViewController, BaseControllerProtocol {
    internal var qtObject: QTGlobalProtocol
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.shared.beginReceivingRemoteControlEvents()
    }

    required init(_ qtObject: QTGlobalProtocol? = QTGlobalInstance.init(tdAttributes: nil), nibName: String?, bundle: Bundle?)
        
    {
        self.qtObject = qtObject!
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
