//
//  BaseAnimator.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 10/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import UIKit

enum ModalAnimatedTransitioningType{
    case Present
    case Dismiss
}
class BaseAnimator:NSObject{
    
    var initialY:CGFloat = 0
    var transitionType:ModalAnimatedTransitioningType = .Present
    
    
    func animatePresentingInContext(context: UIViewControllerContextTransitioning, sourceController:UIViewController, destinationController:UIViewController){
        
        fatalError("Must override this")
    }
    
    func animateDismissingInContext(context: UIViewControllerContextTransitioning, sourceController:UIViewController, destinationController:UIViewController){
    
        fatalError("Must override this")
    }
    
}
extension BaseAnimator:UIViewControllerAnimatedTransitioning{
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        fatalError("Must override this")
        return 0
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        let from = transitionContext.viewController(forKey: .from)
        let to = transitionContext.viewController(forKey: .to)
        
        if let from = from, let to = to{
            switch transitionType{
            case .Present:
                self.animatePresentingInContext(context: transitionContext, sourceController: from, destinationController: to)
                break
            case .Dismiss:
                self.animateDismissingInContext(context: transitionContext, sourceController: from, destinationController: to)
                break
            }
        }
    }
}
