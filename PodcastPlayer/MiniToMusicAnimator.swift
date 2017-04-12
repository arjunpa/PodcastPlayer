//
//  MiniToMusicAnimator.swift
//  PodcastPlayer
//
//  Created by Arjun P A on 11/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class MiniToMusicAnimator: BaseAnimator {
    
    typealias SNAPSHOT_HANDLER = (MiniToMusicAnimator) -> (UIView)
    var snapshotCompletion:SNAPSHOT_HANDLER?
    
    override func animateDismissingInContext(context: UIViewControllerContextTransitioning, sourceController: UIViewController, destinationController: UIViewController) {
        var fromRect = context.initialFrame(for: sourceController)
        fromRect.origin.y = fromRect.size.height - initialY

        let container = context.containerView
        var snapShotViewd:UIView?
        if let snapshotView = snapshotCompletion?(self){
            sourceController.view.addSubview(snapshotView)
            snapshotView.alpha = 0
            snapShotViewd = snapshotView
        }
        container.addSubview(destinationController.view)
        container.addSubview(sourceController.view)
        
        let animOptions:UIViewAnimationOptions = context.isInteractive ? [UIViewAnimationOptions.curveLinear] : []
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, options: animOptions, animations: {
            sourceController.view.frame = fromRect
            snapShotViewd?.alpha = 1
        }) { (flag) in
            snapShotViewd?.removeFromSuperview()
            if context.transitionWasCancelled{
                context.completeTransition(false)
            }
            else{
                context.completeTransition(true)
            }
        }
    }
    
    override func animatePresentingInContext(context: UIViewControllerContextTransitioning, sourceController: UIViewController, destinationController: UIViewController) {
        
        let fromRect = context.initialFrame(for: sourceController)
        var toRect = fromRect
        toRect.origin.y = fromRect.size.height - initialY
        destinationController.view.frame = toRect
        let container = context.containerView
        var snapShotViewd:UIView?
        if let snapshotView = snapshotCompletion?(self){
            destinationController.view.addSubview(snapshotView)
            snapShotViewd = snapshotView
        }
        container.addSubview(sourceController.view)
        container.addSubview(destinationController.view)
        let animOptions:UIViewAnimationOptions = context.isInteractive ? [UIViewAnimationOptions.curveLinear] : []
        
        UIView.animate(withDuration: transitionDuration(using: context), delay: 0, options: animOptions, animations: {
            destinationController.view.frame = fromRect

            snapShotViewd?.alpha = 0
        }) { (flag) in
            snapShotViewd?.removeFromSuperview()
            if context.transitionWasCancelled{
                context.completeTransition(false)
            }
            else{
                context.completeTransition(true)
            }
        }
    }
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionContext!.isInteractive ? 0.4 : 0.3
    }
    
    
}
