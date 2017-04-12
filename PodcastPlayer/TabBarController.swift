//
//  TabBarController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

//    var mytabBarController: UITabBarController!
    
    var qtobject : QTGlobalProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        qtobject = appdelegate?.qtInstance
        
        launchTabBar()
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func launchTabBar(){
//        mytabBarController = UITabBarController()
        var viewControllers = [UINavigationController]()
        
        let itemsArray = ["Listen","Watch","Read","Dedication"]
        
        for (index,item) in itemsArray.enumerated(){
            
            if index == 3{
                let decicationVc = DedicationViewController.newInstance()
                let nc = UINavigationController(rootViewController: decicationVc)
                nc.title = item
                viewControllers.append(nc)
            }else{
            let podController:PodcastPlayerViewController = PodcastPlayerViewController.init(qtobject, nibName: "PodcastPlayerViewController", bundle: nil)
                let nc = UINavigationController(rootViewController: podController)
                nc.title = item
                viewControllers.append(nc)
            }
            
            
        }
        self.viewControllers = viewControllers
//        addViewController(anyController: mytabBarController)
        
    }

}
