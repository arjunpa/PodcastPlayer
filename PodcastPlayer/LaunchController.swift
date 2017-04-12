//
//  LaunchController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Quintype

class LaunchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Quintype.api.getPublisherConfig(cache: .cacheToDiskWithTime(min: 30), Success: { (configData) in
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            let tabBarVC = TabBarController(nibName: "TabBarController", bundle: nil)

            appdelegate?.window?.rootViewController = tabBarVC
            appdelegate?.createLayerWindow(tabBarVC: tabBarVC)
            print(configData)
        }) { (error) in
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
