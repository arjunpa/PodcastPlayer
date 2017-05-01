//
//  ViewControllerExtension.swift
//  PodcastPlayer
//
//  Created by Pavan Gopal on 4/20/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import UIKit

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
