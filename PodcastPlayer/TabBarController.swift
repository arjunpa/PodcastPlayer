//
//  TabBarController.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/10/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class TabBarController: BaseViewController {

    var mytabBarController: UITabBarController!
    
    var qtobject : QTGlobalProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchTabBar()
        // Do any additional setup after loading the view.
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(_ qtObject: QTGlobalProtocol, nibName: String?, bundle: Bundle?) {
        super.init(qtObject, nibName: nibName, bundle: bundle)
        qtobject = qtObject
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func launchTabBar(){
        mytabBarController = UITabBarController()
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
        mytabBarController.viewControllers = viewControllers
        addViewController(anyController: mytabBarController)
        
    }

}

extension UIViewController {
    func addViewController (anyController: AnyObject) {
        if let viewController = anyController as? UIViewController {
            addChildViewController(viewController)
            view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }
    
    func removeViewController (anyController: AnyObject) {
        if let viewController = anyController as? UIViewController {
            viewController.willMove(toParentViewController: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
        }
    }
}
